extends Area2D
class_name HouseArea
@export var house_card_frame: int = 0
@export var rounds: int = 1
# Called when the node enters the scene tree for the first time.
@onready var house_cards = $CardsSprite
# Create var to access which level the housearea is in
# current level the house area is in, used for score increment
@export var current_level = 1
# becomes true if player enters house area
var player_in_area = false
# Access GlobalSIngleton to add points to player per level
#Rival timer that periodically decrements player score
@onready var rivaltimer =$RivalTimer
@export var rivalcooldown: int = 8 
# booleans to determine state of house area
var converted
var rivalconverted
var normal

func _ready():
	rivaltimer.wait_time = rivalcooldown
	house_cards.frame = house_card_frame
	GameGlobalSingleton.house_current_frame = house_cards.frame
	house_cards.hide()

func convert_to_rival():
	rivalconverted = true
	if(current_level == 1):
		pass
			# initial score
		#GameGlobalSingleton.l1_score -= 50
	elif(current_level == 2):
		# initial score
		GameGlobalSingleton.l2_score -= 50
	elif(current_level == 3):
		# initial score
		GameGlobalSingleton.l3_score -= 50
	for child in get_children():
		if child is Villager:
			print("Villager has been converted to your rival!")
			child.voting_rival = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameGlobalSingleton.color_game_running and player_in_area:
		begin_color_game()
	
	if Input.is_action_just_pressed("ui_accept") and GameGlobalSingleton.color_game_running and player_in_area:
		GameGlobalSingleton.house_current_frame = house_card_frame
		if GameGlobalSingleton.house_current_frame == GameGlobalSingleton.player_current_frame and player_in_area:
			# Add correct card effects and points on correct points
			end_color_game()
			if rivaltimer.is_stopped():
				rivaltimer.start()
			#add score corresponding to child house/villagers in house area
			if(current_level == 1):
				# initial score
				GameGlobalSingleton.l1_score += 100
			elif(current_level == 2):
				# initial score
				GameGlobalSingleton.l2_score += 100
			elif(current_level == 3):
				# initial score
				GameGlobalSingleton.l3_score += 100
		else:
			# Add wrong card effects
			pass

	# Ends color game when escape is pressed
	if Input.is_action_just_pressed("ui_cancel") and GameGlobalSingleton.color_game_running:
		end_color_game()
	
	

func begin_color_game():
	house_cards.show()
	
	
func end_color_game():
	house_cards.hide()
	

func _on_rival_timer_timeout():
	convert_to_rival()

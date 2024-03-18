extends Area2D
class_name HouseArea
@export var house_card_frame: int = 0
@export var rounds: int = 1
# Called when the node enters the scene tree for the first time.
@onready var house_cards = $CardsSprite
# current level the house area is in, used for score increment
@export var current_level = 1
# becomes true if player enters house area
var player_in_area = false
# Create var to access which level the housearea is in
# Access GlobalSIngleton to add points to player per level
var timer

func _ready():
	house_cards.frame = house_card_frame
	GameGlobalSingleton.house_current_frame = house_cards.frame
	house_cards.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameGlobalSingleton.color_game_running:
		begin_color_game()
	
	if Input.is_action_just_pressed("ui_accept") and GameGlobalSingleton.color_game_running:
		GameGlobalSingleton.house_current_frame = house_card_frame
		if GameGlobalSingleton.house_current_frame == GameGlobalSingleton.player_current_frame:
			# Add correct card effects and points on correct points
			end_color_game()
			#add score corresponding to child house/villagers in house area
			if(current_level == 1):
				# initial score
				GameGlobalSingleton.l1_score += 10
			elif(current_level == 2):
				# initial score
				GameGlobalSingleton.l2_score += 10
			elif(current_level == 3):
				# initial score
				GameGlobalSingleton.l3_score += 10
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
	

extends Area2D
class_name HouseArea
@export var house_card_frame: int = 0
# Called when the node enters the scene tree for the first time.
@onready var house_cards = $CardsSprite

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
			end_color_game()
	
	# Ends color game when escape is pressed
	if Input.is_action_just_pressed("ui_cancel") and GameGlobalSingleton.color_game_running:
		end_color_game()

func begin_color_game():
	house_cards.show()
	
	
func end_color_game():
	house_cards.hide()
	

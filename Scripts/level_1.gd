extends Node2D

@export var villager_num = 5

@onready var pause_menu = $Player/Camera2D2/PauseMenu
@onready var end_card = $Player/Camera2D2/EndCard
@onready var player = $Player
@onready var text_box = $TextBox

var paused = false
var first_passed = false

func _ready():
	player.set_process_priority(3)
	pause_menu.hide()
	end_card.hide()
	

func _process(delta):
	# Pausing the game
	if Input.is_action_just_pressed("pause") and not GameGlobalSingleton.color_game_running:
		pauseMenu()
	
	if Input.is_action_just_pressed("test_end_level") and not paused:
		endCard()
	
	if text_box.is_empty():
		player.unlock_controls()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = not paused

func endCard():
	end_card.show()
	Engine.time_scale = 1


func _on_text_trigger_body_entered(body):
	if body is Player and not first_passed:
		first_passed = true
		text_box.queue_text("Welcome to Purok Laud, your home purok where you know everyone and everyone knows you!")
		text_box.queue_text("Even with your good reputation here, work to gain the votes of the residents of Purok Laud!")
		text_box.queue_text("You will be given limited time to accomplish your goal.")
		text_box.queue_text("Are you ready?")
		

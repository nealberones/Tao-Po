extends Node2D

@export var villager_num = 5

@onready var pause_menu = $Player/Camera2D2/PauseMenu
@onready var end_card = $Player/Camera2D2/EndCard
@onready var player = $Player
@onready var text_box = $TextBox
@onready var timer = $Timer
@onready var time_left_label = $CanvasLayer/TimeLeftLabel

var paused = false
var first_passed = false
var level_start

func _ready():
	player.set_process_priority(3)
	pause_menu.hide()
	end_card.hide()
	level_start = false

func _process(delta):
	#display remaining time on timer
	time_left_label.text = str(int(timer.time_left))
	
	# Pausing the game
	if Input.is_action_just_pressed("pause") and not GameGlobalSingleton.color_game_running:
		pauseMenu()
	
	if Input.is_action_just_pressed("test_end_level") and not paused:
		endCard()
	
	if text_box.is_empty():
		player.unlock_controls()
		
	if first_passed and text_box.is_empty() and not level_start:
		level_start = true
		timer.start()
	
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
	Engine.time_scale = 0
	
func _on_timer_timeout():
	endCard()


func _on_text_trigger_body_entered(body):
	if body is Player and not first_passed:
		first_passed = true
		text_box.queue_text("Another day, another purok! Welcome to Purok Handa which has more houses. ")
		text_box.queue_text("You will be given 2 minutes and 30 seconds to perform your house-to-house campaigning in this area.")
		text_box.queue_text("The catch now is your rival candidate will also be campaigning in the same purok as you.")
		text_box.queue_text("Another challenge faced in the reality of the Sangguaniang Kabataan elections are vote buying- and the destroying of the reputation of their opponents through gossip and fault-finding.")
		text_box.queue_text("and the destroying of the reputation of their opponents through gossip and fault-finding.")
		text_box.queue_text("Goodluck!")

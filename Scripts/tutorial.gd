extends Node2D

@onready var pause_menu = $Player/Camera2D2/PauseMenu
@onready var player = $Player
@onready var text_box = $TextBox
@onready var villager = $Villager
@onready var house_area = $HouseArea
@onready var end_card = $Player/Camera2D2/EndCard
@onready var animated_sprite_2d = $Villager/AnimatedSprite2D
@onready var quit_label = $QuitLabel

var paused = false
var first_passed = false
var second_passed = false
var third_passed = false
var fourth_passed = false
var fifth_passed = false
var sixth_passed = false

func _ready():
	player.set_process_priority(3)
	house_area.set_process_priority(2)
	villager.set_process_priority(1)
	pause_menu.hide()
	end_card.hide()
	quit_label.hide()

func _process(delta):
	# Pausing the game
	if Input.is_action_just_pressed("pause") and not GameGlobalSingleton.color_game_running:
		pauseMenu()
	
	if Input.is_action_just_pressed("pause") and not GameGlobalSingleton.color_game_running and sixth_passed:
		get_tree().change_scene_to_file("res://Scenes/levels/menu.tscn")

	if Input.is_action_just_pressed("test_end_level") and not paused:
		endCard()
	
	if text_box.is_empty():
		player.unlock_controls()
	
	if Input.is_action_just_pressed("interact") and player.is_near_villager() and villager.is_near_player() and not fourth_passed and not fifth_passed:
		fourth_passed = true
		player.lock_controls()
		text_box.queue_text("Part of winning the elections is building relationships with your potential voters and their circles of influence.")
		text_box.queue_text("Let them feel known and heard!")
		text_box.queue_text("Make them feel that you can be trusted by communicating with them effectively.")
		text_box.queue_text("For this to happen, introduce yourself to him by matching his mood.")
		text_box.queue_text("Do this by giving him the same colored flier you carry.")
		text_box.queue_text("To change the color of the flier, use the “A” or “D” keys to switch left and switch right respectively.")
		text_box.queue_text("To confirm the color of the flier you want to give, click on the Spacebar.")
	
	if Input.is_action_just_pressed("ui_accept") and GameGlobalSingleton.color_game_running and GameGlobalSingleton.house_current_frame == GameGlobalSingleton.player_current_frame and not fifth_passed:
		fifth_passed = true
		player.end_color_game()
		animated_sprite_2d.play("Green")
		player.lock_controls()
		house_area.end_color_game()
		text_box.queue_text("Look at Kuya Roger! He looks happy to have you as a candidate in their barangay.")
		text_box.queue_text("This is how you peak their interest.")
		text_box.queue_text("For a greater assurance of you garnering their vote, try to give the same colored flier as quickly as you can!")
		text_box.queue_text("This increases your total points at the end of the round.")
		text_box.queue_text("Take note! While you are going around, your opponent is going house-to-house in the same purok as you, too.")
		text_box.queue_text("But do not fear! As long as you keep gaining points, you are bound for victory!")
		text_box.queue_text("Time to keep going!")
	
	
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

# First Dialogue
func _on_text_trigger_body_entered(body):
	if body is Player and not first_passed:
		first_passed = true
		player.lock_controls()
		text_box.queue_text("Welcome to tutorial mode!")
		text_box.queue_text("This is where you will uncover the ropes of house-to-house campaigning during SK elections.")
		text_box.queue_text("Understand the processes and learn the factors that make a true SK leader.")
		text_box.queue_text("This is you. That’s what a future youth leader looks like!")
		text_box.queue_text("The game will contain three levels. For each level, you will be exploring a different purok-")
		text_box.queue_text("Purok Laud,")
		text_box.queue_text("Purok Handa,")
		text_box.queue_text("and Purok Dilis.")
		text_box.queue_text("But first things first! For you to move around the street, you need to use your keyboard.")
		text_box.queue_text("To move left, press “A”")
		text_box.queue_text("To move right, press “D”")
		text_box.queue_text("To jump, press “W”")
		text_box.queue_text("Try it!")


# Second Dialogue
func _on_text_trigger_2_body_entered(body):
	if body is Player and not second_passed:
		second_passed = true
		player.lock_controls()
		text_box.queue_text("Great! Keep going!")
		text_box.queue_text("Look for a house to interact with!")
		
		


func _on_text_trigger_3_body_entered(body):
	if body is Player and not third_passed:
		third_passed = true
		player.lock_controls()
		text_box.queue_text("Oh, si Kuya Roger!")
		text_box.queue_text("He’s your classmate’s older brother, but he still doesn’t know you yet.")
		text_box.queue_text("To interact with the houses, click “E”.")
		
		
func _on_text_trigger_4_body_entered(body):
	if body is Player and not sixth_passed:
		sixth_passed = true
		text_box.queue_text("Tao Po! Your adventure in youth awareness begins now.") 
		text_box.queue_text("Campaign wisely, champion your cause, and let the journey to a better community commence!")
		quit_label.show()


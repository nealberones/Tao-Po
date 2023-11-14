extends Node2D

@onready var pause_menu = $Player/Camera2D2/PauseMenu
var paused = false

func _ready():
	pause_menu.hide()

func _process(delta):
	# Pausing the game
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = not paused

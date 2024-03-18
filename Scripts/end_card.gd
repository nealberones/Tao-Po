extends Node2D
@onready var score = $VBoxContainer/VBoxContainer/Score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_next_button_pressed():
	GameGlobalSingleton.next_level()

func _on_restart_button_pressed():
	GameGlobalSingleton.restart_level()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/menu.tscn")

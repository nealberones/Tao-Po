extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_to_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
	Engine.time_scale = 1
	
func _on_quit_game_pressed():
	get_tree().quit()

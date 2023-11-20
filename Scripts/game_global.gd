extends Node

var color_game_running = false
var house_current_frame
var player_current_frame
var l1_score = 0
var l2_score = 0
var l3_score = 0
var total_score = 0
var current_level = 0
var saved_current_level = 0
var player_name = ""

func next_level():
	if(current_level == 0):
		get_tree().change_scene_to_file("res://Scenes/levels/level_1.tscn")
	elif(current_level == 1):
		get_tree().change_scene_to_file("res://Scenes/levels/level_2.tscn")
	elif(current_level == 2):
		get_tree().change_scene_to_file("res://Scenes/levels/level_3.tscn")
	elif(current_level == 3):
		get_tree().change_scene_to_file("res://Scenes/levels/end_screen.tscn")
	current_level += 1
	saved_current_level += 1
	if(current_level>3):
		current_level = 0
		saved_current_level = 0
	Engine.time_scale = 1
	

func restart_level():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://menu.tscn")
	


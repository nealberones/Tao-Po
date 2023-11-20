extends Control


func _on_play_pressed():
	GameGlobalSingleton.next_level()

func _on_quit_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/tutorial.tscn")

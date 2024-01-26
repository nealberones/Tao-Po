extends MarginContainer

@onready var level = $"../../../"
@onready var pause_menu = $"."


var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	level.pauseMenu()

func _on_quit_game_pressed():
	get_tree().quit()

func _on_exit_to_menu_pressed():
	GameGlobalSingleton.exit_to_menu()
	Engine.time_scale = 1
	
	

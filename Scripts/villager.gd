extends Node2D
class_name Villager 

@export var SKIN: String = "res://Animations/villager_1.tres"
@export var color_num = 0
@onready var animatedSprite = $AnimatedSprite2D

var near_player = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	animatedSprite.frames = load(SKIN)
	animatedSprite.play("Idle")

	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and near_player and GameGlobalSingleton.color_game_running:
		if GameGlobalSingleton.house_current_frame == GameGlobalSingleton.player_current_frame:
			print(GameGlobalSingleton.player_current_frame)
			print(GameGlobalSingleton.house_current_frame)
			animatedSprite.play("Green")
		else:
			print(GameGlobalSingleton.player_current_frame)
			print(GameGlobalSingleton.house_current_frame)
			animatedSprite.play("Red")
		print(near_player)


func _on_villager_area_body_entered(body):
	if body is Player:
		print("villager near player!")
		near_player = true


func _on_villager_area_body_exited(body):
	if body is Player:
		print("player left villager!")
		near_player = false

func is_near_player():
	return near_player

func get_color():
	return animatedSprite.get_animation()

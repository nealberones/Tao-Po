extends Node2D
class_name Villager 

@export var SKIN: String = "res://Animations/villager_1.tres"
@export var increment_val : float
@export var color_num = 0
@onready var animatedSprite = $AnimatedSprite2D

# FOR RIVAL SYSTEM: Decrement a certain number of points/ timer 
# Per villager, set decremental value 
# Mistakes decrement score by certain number (can go negative)

var near_player = false
var voting_player
var voting_rival
var voting_neutral
var color_error

func _ready():
	voting_neutral = false
	animatedSprite.frames = load(SKIN)
	animatedSprite.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and near_player and GameGlobalSingleton.color_game_running:
		if GameGlobalSingleton.house_current_frame == GameGlobalSingleton.player_current_frame:
			print(GameGlobalSingleton.player_current_frame)
			print(GameGlobalSingleton.house_current_frame)
			# Add score to player
			voting_player = true
			color_error = false
			voting_rival = false
			#nimatedSprite.play("Green")
		else:
			print(GameGlobalSingleton.player_current_frame)
			print(GameGlobalSingleton.house_current_frame)
			color_error = true
			animatedSprite.play("Red")
		print(near_player)
	elif Input.is_action_just_pressed("ui_cancel") and near_player and GameGlobalSingleton.color_game_running:
		if not voting_player or voting_rival:
			animatedSprite.play("Idle")
	#change color based on state
	if voting_player:
		animatedSprite.play("Green")
	elif voting_rival:
		animatedSprite.play("Red")


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

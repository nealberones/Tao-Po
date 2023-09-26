extends Node2D
class_name Villager 

@export var SKIN: String = "res://villager_1.tres"
@onready var animatedSprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	animatedSprite.frames = load(SKIN)


func _process(delta):
	animatedSprite.play("Idle")

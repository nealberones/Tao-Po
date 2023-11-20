extends Node2D
class_name IdleObject

@export var SKIN: String = "res://Animations/torch.tres"
@onready var animatedSprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	animatedSprite.frames = load(SKIN)


func _process(delta):
	animatedSprite.play("Idle")

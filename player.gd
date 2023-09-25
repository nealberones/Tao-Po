extends CharacterBody2D
class_name Player

@export var SPEED: int = 7.0
@export var JUMP_VELOCITY: int = -300.0
@export var JUMP_RELEASE_FORCE: int = -120
@export var MAX_SPEED: int = 50
@export var ACCELERATION: int = 10
@export var FRICTION: int = 10
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 300)
	# Handle x-axis movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		# flip sprite when moving right
		animatedSprite.flip_h = true
		animatedSprite.play("Walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		# flip sprite when moving left
		animatedSprite.flip_h = false
		animatedSprite.play("Walk")
	else:
		apply_friction()
		animatedSprite.play("Idle")
		
#	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
	else:
		animatedSprite.animation = "Jump"
		animatedSprite.frame = 0
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 0:
			velocity.y += 5
		
	# Para instant yung pagload ng 1st frame sa idle animation	
	var was_in_air = not is_on_floor()
	move_and_slide()
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animatedSprite.play("Idle")
		animatedSprite.frame = 1

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)

extends CharacterBody2D
class_name Player

@export var SPEED: int = 7.0
@export var JUMP_VELOCITY: int = -300.0
@export var JUMP_RELEASE_FORCE: int = -120
@export var MAX_SPEED: int = 50
@export var ACCELERATION: int = 10
@export var FRICTION: int = 10
# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animatedSprite = $AnimatedSprite2D
@onready var Ekey = $EPrompt
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var near_villager = false;
var controls_are_locked = false;

func _ready():
	hide_prompt()

func _process(delta):
	
	# Starts color game when E is pressed near a villager
	if Input.is_action_just_pressed("interact") and near_villager:
		begin_color_game()
		hide_prompt()
	
	# Ends color game when escape is pressed
	if Input.is_action_just_pressed("ui_cancel") and controls_are_locked:
		end_color_game()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 300)
	# Handle x-axis movement
	if Input.is_action_pressed("ui_right") and not controls_are_locked:
		velocity.x += SPEED
		# flip sprite when moving right
		animatedSprite.flip_h = true
		animatedSprite.play("Walk")
	elif Input.is_action_pressed("ui_left") and not controls_are_locked:
		velocity.x -= SPEED
		# flip sprite when moving left
		animatedSprite.flip_h = false
		animatedSprite.play("Walk")
	else:
		apply_friction()
		animatedSprite.play("Idle")
		
#	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up") and not controls_are_locked:
			velocity.y = JUMP_VELOCITY
	else:
		animatedSprite.animation = "Jump"
		animatedSprite.frame = 0
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE and not controls_are_locked:
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
	
func hide_prompt():
	Ekey.hide()

func show_prompt():
	Ekey.show()
	Ekey.play("Pressme")


func _on_house_detect_area_entered(area):
	if area is HouseArea:
		near_villager = true 
		show_prompt()


func _on_house_detect_area_exited(area):
	if area is HouseArea: 
		near_villager = false
		Ekey.hide()

func begin_color_game():
	controls_are_locked = true
	$Camera2D.zoom = Vector2(4, 4)
	
func end_color_game():
	controls_are_locked = false
	$Camera2D.zoom = Vector2(2, 2)

extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var joystick = $"../HUD/LeftStick/Joystick"

var direction = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.get_axis("move_left", "move_right"):
		direction = Input.get_axis("move_left", "move_right")
	else:
		print(joystick.posVector)
		#stc this is the part where you can change values to add a walk mechanic
		if joystick.posVector.x > 0.25:
			direction = 1
		elif joystick.posVector.x < -0.25:
			direction = -1
		#elif joystick.posVector.y == 0 :
		else:
			direction = 0
	
	#sets sprite direction
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
	
	#sets animation
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		elif direction != 0:
			animated_sprite_2d.play("run")
	elif Input.is_action_pressed("jump") && not is_on_floor() :
		animated_sprite_2d.play("jump")

	#applies movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#func _process(delta):
	#if Input.is_action_pressed("jump") && not is_on_floor() :
		#animated_sprite_2d.play("jump")
	move_and_slide()

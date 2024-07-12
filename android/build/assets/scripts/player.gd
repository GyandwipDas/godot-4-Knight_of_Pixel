extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var joystick = $"../HUD/LeftStick/Joystick"
@export var SPEED = 125.0
@export var JUMP_VELOCITY = -300.0
@export var JUMP_BUFFER_TIMER = .1
const JUMP_BUFFER = false


var direction = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("char_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.get_axis("char_move_left", "char_move_right"):
		direction = Input.get_axis("char_move_left", "char_move_right")
	else:
		#print(joystick.posVector)
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
	elif Input.is_action_pressed("char_jump") && not is_on_floor() :
		animated_sprite_2d.play("jump")

	#applies movement
	if direction:
		velocity.x = direction * SPEED
		#velocity.x = min(velocity.x + acc, SPEED)
		
		if Input.is_action_pressed("shift"): #teleport/ DASH IF YOU USE is_action_just_pressed
			#velocity.x = velocity.x * 2
			velocity.x = lerp(velocity.x, velocity.x*10, .1)
			print(velocity.x)
	else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x = lerp(velocity.x, 0.0, .15)

#func _process(delta):
	#if Input.is_action_pressed("jump") && not is_on_floor() :
		#animated_sprite_2d.play("jump")
	move_and_slide()

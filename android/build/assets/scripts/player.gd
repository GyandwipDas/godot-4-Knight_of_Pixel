extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var joystick = $"../HUD/LeftStick/Joystick"
@onready var coyote_timer = $CoyoteTimer
@export var SPEED = 125.0
@export var JUMP_VELOCITY = -300.0

var direction = 0
var coyote_time = .5
var can_jump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if can_jump == false && is_on_floor():
		can_jump = true
	if can_jump == true && coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	if Input.is_action_just_pressed("char_jump") and can_jump:
		velocity.y = JUMP_VELOCITY
		can_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.get_axis("char_move_left", "char_move_right"):
		direction = Input.get_axis("char_move_left", "char_move_right")
	else:
		#print(joystick.posVector)
		#stc this is the part where you can change values to add a walk mechanic
		#if joystick.posVector.x >= -0.1 && joystick.posVector.x <= 0.1:
			#direction = 0
		if joystick.posVector.x > 0:
			direction = 1
			print(joystick.posVector.x)
		elif joystick.posVector.x < -0:
			direction = -1
			print(joystick.posVector.x)
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
		#if joystick.posVector.x < -0.1 && joystick.posVector.x > 0.1:
		velocity.x = direction * SPEED
		#velocity.x = min(velocity.x + acc, SPEED)
		
		if Input.is_action_pressed("shift"): #teleport/ DASH IF YOU USE is_action_just_pressed
			#velocity.x = velocity.x * 2
			velocity.x = lerp(velocity.x, velocity.x * 2.5, .15)
			#print(velocity.x)
	if Input.is_action_pressed("shift"): #teleport/ DASH IF YOU USE is_action_just_pressed
			animated_sprite_2d.speed_scale = lerp(1.0, 2.5, .5)
	else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x = lerp(velocity.x, 0.0, .25) #slide on leaving movement key
		#print(velocity.x)
		animated_sprite_2d.speed_scale = 1
	move_and_slide()


func _on_coyote_timer_timeout():
	can_jump = false

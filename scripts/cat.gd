extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var joystick = $"../HUD/LeftUI/Joystick"

@onready var coyote_timer = $CoyoteTimer
@export var SPEED = 150.0
@export var JUMP_VELOCITY = -325.0
@export var JOYSTICK_RUN_SPEED = 1.25

var direction = 0
var coyote_time = .5
var can_jump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	 #Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if game_manager.PlayerPOVCam == game_manager.Player.cat:
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
			if joystick.posVector.x > 0:
				direction = 1
			elif joystick.posVector.x < 0:
				direction = -1
			else:
				direction = 0
		
		#sets sprite direction
		if direction == 1:
			animated_sprite_2d.flip_h = false
		elif direction == -1:
			animated_sprite_2d.flip_h = true

		#applies movement
		if direction:
			if joystick.pressing:
				velocity.x = direction * SPEED * JOYSTICK_RUN_SPEED * abs(joystick.posVector.x)
				animated_sprite_2d.speed_scale = abs(joystick.posVector.x) * 1.25
			else: 
				velocity.x = direction * SPEED
			
			if Input.is_action_pressed("shift"): #teleport/ DASH IF YOU USE is_action_just_pressed
				velocity.x = lerp(velocity.x, velocity.x * 5, .1)
				animated_sprite_2d.speed_scale = lerp(1.0, 2.75, .3)
				pass
		else:
			velocity.x = lerp(velocity.x, 0.0, .25) #slide on leaving movement key
			animated_sprite_2d.speed_scale = 1
	else:
		velocity.x = 0
		direction = 0
	
	#sets animation
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	move_and_slide()


func _on_coyote_timer_timeout():
	can_jump = false

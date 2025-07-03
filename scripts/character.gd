extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var joystick: Node2D = $"../../HUD/LeftUI/Joystick"
@onready var game_manager: Node = $"../../GameManager"
@onready var area_2d: Area2D = $Area2D
@onready var rope_timer: Timer = $RopeTimer
#@onready var rope_swing_comb: Node2D = $"../../Rope swings/RopeSwingComb"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@onready var coyote_timer = $CoyoteTimer
@export var SPEED = 90
@export var JUMP_VELOCITY = -300.0
@export var JOYSTICK_RUN_SPEED = 1.25

var direction = 0
var coyote_time = .5
var can_jump = false
var inputs_allowed = true
var falling_var = 1
var anim_speed_scale = 1 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var time_scale

var rope_grabbed = false
var rope_part = null
var can_grab = true

func _physics_process(delta):
	#print(position)
	#print(Engine.time_scale)
	 #Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * (delta/falling_var)
			
	if game_manager.PlayerPOVCam == game_manager.Player.char:
		# Handle jump.
		if can_jump == false && is_on_floor():
			can_jump = true
		if can_jump == true && coyote_timer.is_stopped():
			coyote_timer.start(coyote_time)
		if Input.is_action_just_pressed("char_jump") && can_jump && inputs_allowed:
			velocity.y = JUMP_VELOCITY
			can_jump = false
			
		#variable jump
		#if Input.is_action_just_released("char_jump") && inputs_allowed:
			#velocity.y *= 0.35
			
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if Input.get_axis("char_move_left", "char_move_right"):
			direction = Input.get_axis("char_move_left", "char_move_right")
		else:
			if joystick.posVector.x > 0:
				direction = 1
				#print(joystick.posVector.x)
			elif joystick.posVector.x < 0:
				direction = -1
				#print(joystick.posVector.x)
			else:
				direction = 0
		
		#sets sprite direction
		if direction == 1:
			animated_sprite_2d.flip_h = false
		elif direction == -1:
			animated_sprite_2d.flip_h = true

		#applies movement
		if direction && inputs_allowed:
			if joystick.pressing:
				velocity.x = direction * SPEED * JOYSTICK_RUN_SPEED * abs(joystick.posVector.x)
				animated_sprite_2d.speed_scale = abs(joystick.posVector.x) * 1.5 / anim_speed_scale
				print(animated_sprite_2d.speed_scale)
			else: 
				velocity.x = direction * SPEED
			
			if Input.is_action_pressed("shift"): #teleport/ DASH IF YOU USE is_action_just_pressed
				velocity.x = lerp(velocity.x, velocity.x * 5, .1)
				animated_sprite_2d.speed_scale = lerp(1.0/anim_speed_scale, 2.75/anim_speed_scale, .3)
				#print(animated_sprite_2d.speed_scale)
				pass
		else:
			velocity.x = lerp(velocity.x, 0.0, .15) #slide on leaving movement key
			animated_sprite_2d.speed_scale = 1 / anim_speed_scale
	else: 
		velocity.x = 0
		direction = 0
	#sets animation
	if is_on_floor() && inputs_allowed:
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	elif inputs_allowed:
		animated_sprite_2d.play("jump")
	else:
		animated_sprite_2d.play("idle")
		
	move_and_slide()
	
	#Rope code stuff
	#var rope_release = false
	#if rope_grabbed:
		#global_position = rope_part.global_position
		#if Input.is_action_just_pressed("char_jump"):
			#rope_part.get_parent().get_child(2).set_deferred_thread_group("disabled", false)
			#rope_grabbed = false
			#rope_part = null
			#rope_timer.start()
			#rope_release = true
			##collision_shape_2d.disabled = false
		#else:
			#return
	
	
	#if Input.is_key_pressed(KEY_V):
		#print("hi")


func _on_coyote_timer_timeout():
	can_jump = false

func _ready():
	#print(game_manager.nodeData["playerPos"])
	game_manager.loadGame()
	print(game_manager.nodeData["playerPos"])
	var arr = game_manager.nodeData["playerPos"]
	
	#string(JSON) to vector2 There has to be a better way jeez
	arr = arr.split(",")
	var arr1 = arr[0].split("(")[1]
	var arr2 = arr[1].split(")")[0]
	
	#arrgame_manager.stringToVec2(arr)

	#loading postion from save file
	#position = Vector2(float(arr1), float(arr2)) 
	pass

func slowmospeed(to_time_scale: float, lerp_time_scale: bool = false, time_scale_wt: int = 0.5):
	if lerp_time_scale:
		#lerp(velocity.x, velocity.x * 5, .1)
		#lerp(gravity, grav, lerp_scale)
		#lerp(Engine.time_scale, 0, 1)
		print("LERPING ENGINE TIME SCALE")
		#lerp(Engine.time_scale, to_time_scale, time_scale_wt)
		var tween_time = create_tween()
		#tween_time.tween_property(animated_sprite_2d, "scale", Vector2(1,1), 1)
		tween_time.tween_property(Engine, "time_scale", to_time_scale, 1 )
		tween_time.connect("finished", on_slowmo_done)
		time_scale = to_time_scale
	else:
		#gravity = 800
		#gravity = grav
		#Engine.time_scale = 0.65
		Engine.time_scale = to_time_scale
		#lerp(animated_sprite_2d.scale, 1, 1)
	#anim_speed_scale = 10
	#anim_speed_scale = anim_speed


#func slowmospeed():
	#gravity = 800
	#anim_speed_scale = 2
	
	
func on_slowmo_done():
	print("Slowmo done")
	Engine.time_scale = time_scale

func normalspeed():
	print("RESETING TIME SCALE")
	var tween_time = create_tween()
	tween_time.tween_property(Engine, "time_scale", 1, .1)
	tween_time.set_loops(0)
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	#anim_speed_scale = 1
	Engine.time_scale = 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("GROUPS->",get_groups())
	if can_grab:
	#if area ==  
		#collision_shape_2d.disabled = true
		rope_grabbed = true
		can_grab = false
		rope_part = area
		print(area.get_parent().get_parent())
		#area.get_parent().get_child(2).set_deferred_thread_group("disabled", true)
		print("grabbing!")
	pass # Replace with function body.


func _on_rope_timer_timeout() -> void:
	can_grab = true
	pass # Replace with function body.

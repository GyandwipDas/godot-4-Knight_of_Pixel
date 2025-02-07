#extends Area2D
#
#@onready var character: CharacterBody2D = $"../../../character"
#@onready var camera: Camera2D = $"../../Camera"
#@onready var game_manager: Node = %GameManager
#@onready var cat: CharacterBody2D = $"../../../cat"
#@onready var icon: Sprite2D = $Path2D/PathFollow2D/Icon
#@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
#@onready var bridge_comb: Node2D = $"../../../Bridge stuff/BridgeComb"
#
#@onready var zoom_timer: Timer = $ZoomTimer
#@onready var cam_switch_back_timer: Timer = $CamSwitchBackTimer
#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#@onready var bridge_plank_break: Timer = $"bridge plank break"
#
#var cam_switch = false
##var bridge_plank_break_timer: Timer = Timer.new()
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if cam_switch:
		#game_manager.puzzle_pos = icon.global_position
	##else:
		##game_manager.puzzle_pos = null
	#pass
#
#
#func _on_area_entered(area: Area2D) -> void:
	##print("Calling break_plank_timer()")
	##bridge_plank_break.start()
	#var tween = create_tween()
	#if area == character.area_2d:
		#var path_folw_anim = get_child(4).get_child(0).get_child(0).get_child(0)
		#
		#print(get_child(4).get_child(0).get_child(0).get_child(0))
		#cam_switch = true
		##game_manager.puzzle_pos = icon.global_position
		#
		#tween.tween_property(camera, "zoom", Vector2(2.5, 2.5), 5)
		#
		#character.inputs_allowed = false
		#path_folw_anim.play("path_mvt")
		#zoom_timer.start()
		#cam_switch_back_timer.start()
	#pass # Replace with function body.
#
#
#
#func _on_zoom_timer_timeout() -> void:
	#var tween = create_tween()
	#tween.tween_property(camera, "zoom", Vector2(4, 4), 2.5)
	#collision_shape_2d.disabled = true
	#character.inputs_allowed = true
	#
	#pass # Replace with function body.
#
#
#func _on_cam_switch_back_timer_timeout() -> void:
	#print("switched back to char")
	#cam_switch = false
	#game_manager.puzzle_pos = null
	#
	#pass # Replace with function body.
#
#
#
#func _on_bridge_plank_break_timeout() -> void:
	##print("Breaking planks")
	##print(bridge_comb.break_plank(1))
	#
	#pass # Replace with function body.


#-=-----------------------------------------------------------------------------

extends Area2D

@onready var character: CharacterBody2D = $"../../../character"
@onready var camera: Camera2D = $"../../Camera"
@onready var game_manager: Node = %GameManager
@onready var cat: CharacterBody2D = $"../../../cat"
@onready var icon: Sprite2D = $Path2D/PathFollow2D/Icon
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var bridge_comb: Node2D = $"../../../Bridge stuff/BridgeComb"
@onready var load_anim: AnimatedSprite2D = $"../../../HUD/RightUI/LoadAnim"

@onready var zoom_timer: Timer = $ZoomTimer
@onready var cam_switch_back_timer: Timer = $CamSwitchBackTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bridge_plank_break: Timer = $"bridge plank break"

var cam_switch = false
var in_area = false
var skipped = false
var skip_count = 0
#var tween = get_tree().create_tween()

#var bridge_plank_break_timer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _input(event: InputEvent) -> void:
func _process(delta: float) -> void:
	if cam_switch:
		game_manager.puzzle_pos = icon.global_position
	#else:
		#game_manager.puzzle_pos = null
	#Checking if skip is held for 1s
	pass
	
func _input(event: InputEvent) -> void:
	if in_area:
		if Input.is_action_pressed("char_jump"):
		#if event.is_action("char_jump"):
			var skip_held_timer = Timer.new()
			add_child(skip_held_timer)
			skip_held_timer.one_shot = true
			skip_held_timer.timeout.connect(check_skip_held)
			skip_held_timer.start(1.5)
			
			var skip_held_anim = Timer.new()
			add_child(skip_held_anim)
			skip_held_anim.one_shot = true
			skip_held_anim.timeout.connect(func(): load_anim.play("load"))
			skip_held_anim.start(0.75)
	
#func play_load_anim():
	#if skip_count == 0:
		#load_anim.play("load")

func check_skip_held():
	if Input.is_action_pressed("char_jump"):
		print("Skipping anim")
		var path_folw_anim = get_child(4).get_child(0).get_child(0).get_child(0)
		print(get_child(4).get_child(0).get_child(0).get_child(0))
		path_folw_anim.play("RESET")
		skipped = true
		var tween = create_tween()
		#tween.kill()
		#tween.tween_property(camera, "zoom", Vector2(4, 4), 0.1)
		
		var zoom_fac = 5
		tween.tween_property(camera, "zoom", Vector2(4, 4), zoom_fac)
		zoom_fac *= 5
		tween.set_speed_scale(zoom_fac)
		tween.set_loops(0)
		tween.finished
		queue_free() if !tween.is_running() else print(tween.get_loops_left())
		character.inputs_allowed = true
		print("switched back to char")
		cam_switch = false
		game_manager.puzzle_pos = null
		#load_anim.stop()
		#load_anim.frame = 0

func _on_area_entered(area: Area2D) -> void:
	var tween = create_tween()
	#print("Calling break_plank_timer()")
	#bridge_plank_break.start()
	if area == character.area_2d:
		in_area = true
		var path_folw_anim = get_child(4).get_child(0).get_child(0).get_child(0)
		#print(get_child(4).get_child(0).get_child(0).get_child(0))
		cam_switch = true
		#game_manager.puzzle_pos = icon.global_position
		
		tween.tween_property(camera, "zoom", Vector2(2.5, 2.5), 5)
		
		character.inputs_allowed = false
		path_folw_anim.play("path_mvt")
		zoom_timer.start()
		cam_switch_back_timer.start()
	pass # Replace with function body.



func _on_zoom_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "zoom", Vector2(4, 4), 3)
	collision_shape_2d.disabled = true
	character.inputs_allowed = true
	
	pass # Replace with function body.


func _on_cam_switch_back_timer_timeout() -> void:
	print("switched back to char")
	cam_switch = false
	game_manager.puzzle_pos = null
	queue_free()
	pass # Replace with function body.




func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		in_area = false
		if skipped:
			queue_free()
	pass # Replace with function body.

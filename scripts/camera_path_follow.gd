extends Area2D

@onready var character: CharacterBody2D = $"../../../character"
@onready var camera: Camera2D = $"../../Camera"
@onready var game_manager: Node = %GameManager
@onready var cat: CharacterBody2D = $"../../../cat"
@onready var icon: Sprite2D = $Path2D/PathFollow2D/Icon
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var bridge_comb: Node2D = $"../../../Bridge stuff/BridgeComb"

@onready var zoom_timer: Timer = $ZoomTimer
@onready var cam_switch_back_timer: Timer = $CamSwitchBackTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var bridge_plank_break: Timer = $"bridge plank break"

var cam_switch = false
#var bridge_plank_break_timer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cam_switch:
		game_manager.puzzle_pos = icon.global_position
	#else:
		#game_manager.puzzle_pos = null
	pass


func _on_area_entered(area: Area2D) -> void:
	#print("Calling break_plank_timer()")
	#bridge_plank_break.start()
	var tween = create_tween()
	if area == character.area_2d:
		var path_folw_anim = get_child(4).get_child(0).get_child(0).get_child(0)
		
		print(get_child(4).get_child(0).get_child(0).get_child(0))
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
	tween.tween_property(camera, "zoom", Vector2(4, 4), 2.5)
	collision_shape_2d.disabled = true
	character.inputs_allowed = true
	
	pass # Replace with function body.


func _on_cam_switch_back_timer_timeout() -> void:
	print("switched back to char")
	cam_switch = false
	game_manager.puzzle_pos = null
	
	pass # Replace with function body.



func _on_bridge_plank_break_timeout() -> void:
	#print("Breaking planks")
	#print(bridge_comb.break_plank(1))
	
	pass # Replace with function body.

extends Area2D

@onready var character: CharacterBody2D = $"../../../character"
@onready var camera: Camera2D = $"../../Camera"
@onready var game_manager: Node = %GameManager
@onready var cat: CharacterBody2D = $"../../../cat"
@onready var icon: Sprite2D = $Path2D/PathFollow2D/Icon
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var cam_switch = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if cam_switch:
		var tween = create_tween()
		var path_folw_2d = get_child(1).get_child(0)
		game_manager.puzzle_pos = icon.global_position
		tween.tween_property(path_follow_2d, "progress_ratio", .5, 7.5).set_trans(Tween.TRANS_LINEAR)
	pass


func _on_area_entered(area: Area2D) -> void:
	var tween = create_tween()
	if area == character.area_2d:
		#print(get_child(1).get_child(0).get_child(0))
		var cam_ctrl = get_child(1).get_child(0).get_child(0)
		var path_folw_2d = get_child(1).get_child(0)
		print("cam_ctrl = ", cam_ctrl.get_path(), " path_folw_2d = ", path_folw_2d)
		cam_switch = true
		#game_manager.puzzle_pos = icon.global_position
		#tween.tween_property(path_follow_2d, "progress_ratio", .5, 5)
		tween.tween_property(camera, "zoom", Vector2(2.5, 2.5), 5)
		#tween.tween_property(path_folw_2d, "progress_ratio", 0.5, 2)
	pass # Replace with function body.

#func cam_follow(delta: float):
	#var tween = create_tween()
	#var path_folw_2d = get_child(1).get_child(0)
	#game_manager.puzzle_pos = icon.global_position
	#tween.tween_property(path_follow_2d, "progress_ratio", .5, 5)

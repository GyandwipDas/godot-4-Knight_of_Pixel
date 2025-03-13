extends Area2D
@onready var character: CharacterBody2D = $"../../Characters/character"
@onready var game_manager: Node = %GameManager

@export var to_time_scale: float
@export var time_scale_wt: float
@export var lerp_time_scale: bool = false
@export var play_anim: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
	#if area == character.area_2d:
	#if area == character.area_2d && (need_anim && play_anim) || (!need_anim && !play_anim):
		print("Slowing down time")
		character.slowmospeed(to_time_scale, lerp_time_scale, time_scale_wt)
		#character.slowmospeed()
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
		character.normalspeed()
		game_manager.loadGame()
		game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(-591, -43), 2, 0, SaveInfo.slot)

	pass # Replace with function body.

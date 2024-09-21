extends Node2D

@onready var game_manager = %GameManager
@onready var character = $character
@onready var cat = $cat
@onready var camera = $"Camera Stuff/Camera"

# Called when the node enters the scene tree for the first time.
func _ready():
	#game_manager.loadGame()
	camera.make_current()
	pass


func _on_smooth_cam_to_char_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.
 

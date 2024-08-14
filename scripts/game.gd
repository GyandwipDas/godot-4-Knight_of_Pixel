extends Node2D

@onready var game_manager = %GameManager
@onready var character = $character
@onready var cat = $cat
@onready var camera = $"Camera Stuff/Camera"

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.make_current()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#camera switch 
	if game_manager.PlayerPOVCam == game_manager.Player.char:
		camera.global_position = character.global_position
	else:
		camera.global_position = cat.global_position
	pass

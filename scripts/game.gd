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

extends Area2D
@onready var character: CharacterBody2D = $"../character"
@onready var camera: Camera2D = $"../Camera"

var rng = RandomNumberGenerator.new()
var duration = 0
var force

func _process(delta: float) -> void:
	if duration > 0:
		var forcex = rng.randf_range(-1, 1)
		var forcey = rng.randf_range(-1, 1)
		
		var offset = Vector2(forcex, forcey)

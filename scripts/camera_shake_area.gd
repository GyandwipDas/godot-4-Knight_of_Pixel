extends Area2D
@onready var character: CharacterBody2D = $"../character"
@onready var camera: Camera2D = $"../Camera"
	
@export var intensity = 30
@export var duration = 1
@export var start_time = 0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shake_camera(intensity = 1.0, duration = 1.0):
	pass

func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("Shaking")
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		print("Stopped Shaking")
	pass # Replace with function body.

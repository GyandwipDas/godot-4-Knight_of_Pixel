extends Area2D
@onready var character: CharacterBody2D = $"../../character"
@onready var camera: Camera2D = $"../Camera"
	
@export var rand_strength: float = 30
@export var shake_fade: float = 5

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0
var enable_shake = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if enable_shake:
		#if shake_strength > 0:
			#shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
			#print(shake_offset())
			#if shake_strength == 0:
				#enable_shake = false
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("Starting camera shake")
		shake_strength = rand_strength
		enable_shake = true
		#if shake_strength > 0:
			#shake_strength = lerpf(shake_strength, 0, shake_fade)
	pass # Replace with function body.


#func _on_area_exited(area: Area2D) -> void:
	#if area == character.area_2d:
		#print("Ending camera shake")
	#pass # Replace with function body.


func shake_offset():
	return Vector2(rng.randf_range(-rand_strength,rand_strength), rng.randf_range(-rand_strength,rand_strength))

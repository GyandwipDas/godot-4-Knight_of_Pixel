extends Area2D

@onready var character: CharacterBody2D = $"../../character"
@onready var cat: CharacterBody2D = $"../../cat"
@onready var game_manager: Node = %GameManager
@onready var camera: Camera2D = $"../Camera"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	
	if area == character.area_2d:
		#print("char falling")
		#camera.position_smoothing_speed = 20
		game_manager.falling = true
		character.gravity = 50
		character.falling_var = 1000
		
		#print(get_child(1))
	pass # Replace with function body.

extends AnimationPlayer

@onready var character: CharacterBody2D = $"../../character"
@onready var game_manager: Node = %GameManager
var passed_once = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == character.area_2d && game_manager.nodeData["memory"] == 1 && !passed_once:
		passed_once = true
		play("new_animation")
		#play("anim player block")
	pass # Replace with function body.

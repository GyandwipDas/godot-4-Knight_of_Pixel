extends Area2D
@onready var timer: Timer = $Timer
@onready var character: CharacterBody2D = $"../../../character"
@onready var bridge_comb: Node2D = $"../../BridgeComb"

@export var time_to_break : float = 0.0
@export var plank_to_break : int = 1
@export var on_enter : bool = true

func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d && on_enter == true:
		timer.start(time_to_break)
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	bridge_comb.break_plank(plank_to_break)
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d && on_enter == false:
		timer.start(time_to_break)
	pass # Replace with function body.

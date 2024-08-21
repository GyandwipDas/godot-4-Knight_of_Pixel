extends Area2D

@onready var character: CharacterBody2D = $"../character"
var memory_scene = preload("res://scenes/memory.tscn")


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("Showing cutscene")
		get_tree().change_scene_to_packed(memory_scene)
	pass # Replace with function body.

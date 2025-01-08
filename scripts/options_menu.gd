extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Music.set("parameters/switch_to_clip", "Lm 1 - Lure Of The Maw")
	#Music.music_switcher("Lm 1 - Lure Of The Maw")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	pass # Replace with function body.

extends Control

var game_menu_scene = preload("res://scenes/game menu.tscn")
var options_menu_scene = preload("res://scenes/options_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/game menu.tscn")
	get_tree().change_scene_to_packed(game_menu_scene)

	pass # Replace with function body.


func _on_options_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
	get_tree().change_scene_to_packed(options_menu_scene)
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

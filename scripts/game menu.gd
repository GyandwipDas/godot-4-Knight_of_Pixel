extends Control

@onready var warning: Label = $"MarginContainer/VBoxContainer/New Game/Label"
var new_game_counter = 0
const game_scene = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	if new_game_counter == 0:
		warning.show()
		new_game_counter += 1
	else: 
		DirAccess.remove_absolute("user://Gumm.save")
		#get_tree().change_scene_to_file("res://scenes/game.tscn")
		get_tree().change_scene_to_packed(game_scene)
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	#game_manager.loadGame()
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	get_tree().change_scene_to_packed(game_scene)
	pass # Replace with function body.


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	pass # Replace with function body.

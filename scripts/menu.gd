extends Control

const game_scene = preload("res://scenes/game.tscn")
const options_menu_scene = preload("res://scenes/options_menu.tscn")
const slots_menu = preload("res://scenes/slots_menu.tscn")

@onready var play_btn: Button = $"MarginContainer/VBoxContainer/Play"
@onready var continue_game_btn: Button = $"MarginContainer/VBoxContainer/Continue"
@onready var new_game_btn: Button = $"MarginContainer/VBoxContainer/New Game"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	if DirAccess.get_files_at("user://"):
		#print(DirAccess.get_files_at("user://"))
		print("There's a saved game!")
		play_btn.visible = false
		continue_game_btn.visible = true
		new_game_btn.visible = true
	else:
		print("There's no saved game!")
		play_btn.visible = true
		continue_game_btn.visible = false
		new_game_btn.visible = false
	#print("<<<>>>")
	#get_tree().call_group("slots_menu", "menu_function", "continue")
	
	#var slot_menu_inst = slots_menu.instantiate()
	#slot_menu_inst.menu_func("THIS IS INSTANTIATED")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print("Play pressed")
	#get_tree().change_scene_to_file("res://scenes/game menu.tscn")
	get_tree().change_scene_to_packed(game_scene)
	pass # Replace with function body.


func _on_options_pressed() -> void:
	print("Option pressed")
	#get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
	get_tree().change_scene_to_packed(options_menu_scene)
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	print("Quit pressed")
	get_tree().quit()
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	print("Continue pressed")
	#get_tree().change_scene_to_packed(game_scene)
	SaveInfo.continue_game = true
	SaveInfo.new_game = false
	print("Continue game?",SaveInfo.continue_game, "\nNew game?", SaveInfo.new_game)
	get_tree().change_scene_to_packed(slots_menu)
	#get_tree().call_group(slots_menu, slots_menu.menu_function("continue"))
	#slots_menu.continue_game.emit()
	#slots_menu.menu_function("continue game");
	pass # Replace with function body.


func _on_new_game_pressed() -> void:
	print("New Game pressed")
	SaveInfo.continue_game = false
	SaveInfo.new_game = true
	print("Continue game?",SaveInfo.continue_game, "\nNew game?", SaveInfo.new_game)
	#DirAccess.remove_absolute("user://Gumm.save")
	#get_tree().change_scene_to_packed(game_scene)
	get_tree().change_scene_to_packed(slots_menu)
	#slots_menu.new_game.emit()
	#slots_menu.menu_function("new game");

	pass # Replace with function body.

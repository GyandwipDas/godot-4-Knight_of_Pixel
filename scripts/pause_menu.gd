extends Control

#const MAIN_MENU = preload("res://scenes/main menu.tscn")

var game_manager

func _ready() -> void:
	var file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"

	var savedGame = FileAccess.open(file_name, FileAccess.READ)
	#SaveInfo.slot = slot
	file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
	
	var jsonString = savedGame.get_line()
	var json = JSON.new()
	json.parse(jsonString)
	var nodeData = json.get_data()
	
	game_manager = %GameManager if nodeData["level"] == 1 else $"../../GameManager"

func _on_resume_pressed():
	game_manager.pauseGame()

func _on_controller_type_pressed():
	game_manager.switchJoystick()


func _on_quit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	#get_tree().change_scene_to_packed(MAIN_MENU)
	pass # Replace with function body.


func _on_quit_to_desktop_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

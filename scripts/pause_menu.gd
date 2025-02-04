extends Control

#const MAIN_MENU = preload("res://scenes/main menu.tscn")

@onready var game_manager = %GameManager


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

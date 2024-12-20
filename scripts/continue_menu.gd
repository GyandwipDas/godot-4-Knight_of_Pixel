extends Control

const game_scene = preload("res://scenes/game.tscn")

var file_name

signal menu_function

func _ready() -> void:
	
	if SaveInfo.continue_game:
		print("continuing game from slot")
	else:
		print("starting new game")
		
	pass # Replace with function body.

func continue_or_start_game(slot : int):
	SaveInfo.slot = slot
	file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"

	if SaveInfo.continue_game:
		print("slot", SaveInfo.slot)
		print(file_name)
		get_tree().change_scene_to_packed(game_scene)
	else:
		print("slot", SaveInfo.slot)
		DirAccess.remove_absolute(file_name)
		print(file_name)
		get_tree().change_scene_to_packed(game_scene)

#func menu_function():
	#if SaveInfo.continue_game:
		#print("continuing game")
	#else:
		#print("starting new game")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	#get_tree().change_scene_to_packed(MAIN_MENU)
	pass # Replace with function body.


func _on_slot_1_pressed() -> void:
	#SaveInfo.slot = 1
	#print(SaveInfo.slot)
	#
	##call warning here
	#
	#DirAccess.remove_absolute("user://Gumm.save")
#
	#
	#get_tree().change_scene_to_packed(game_scene)
	continue_or_start_game(1)
	pass # Replace with function body.


func _on_slot_2_pressed() -> void:
	#SaveInfo.slot = 2
	#print(SaveInfo.slot)
	#
	##call warning here
	#
	#DirAccess.remove_absolute("user://Gumm.save")
#
	#
	#get_tree().change_scene_to_packed(game_scene)
	continue_or_start_game(2)
	pass # Replace with function body.


func _on_slot_3_pressed() -> void:
	#SaveInfo.slot = 3
	#print(SaveInfo.slot)
	#
	##call warning here
	#
	#DirAccess.remove_absolute("user://Gumm.save")
#
	#
	#get_tree().change_scene_to_packed(game_scene)
	continue_or_start_game(3)
	pass # Replace with function body.


func _on_menu_function() -> void:
	pass # Replace with function body.

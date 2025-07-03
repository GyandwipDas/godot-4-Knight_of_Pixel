#extends Control
#
##const game_scene = preload("res://scenes/game.tscn")
#var game_scene 
#var file_name
#
#signal menu_function
#
#func _ready() -> void:
	#
	#if SaveInfo.continue_game:
		#print("continuing game from slot")
	#else:
		#print("starting new game")
	#pass # Replace with function body.
#
#func continue_or_start_game(slot : int):
	#SaveInfo.slot = slot
	#file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
	#
	#var file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
	#var savedGame = FileAccess.open(file_name, FileAccess.READ)
	#var nodeData 
	#
	#if savedGame:
		#while savedGame.get_position() < savedGame.get_length():
			#var jsonString = savedGame.get_line()
			#var json = JSON.new()
			#json.parse(jsonString)
			#nodeData = json.get_data()
			#game_scene = preload("res://scenes/level1.tscn") if nodeData["level"] == 1 else preload("res://scenes/level2.tscn")
			##file_name = "res://scenes/level1.tscn" if nodeData["level"] == 1 else "res://scenes/level2.tscn"
	#else:
		#game_scene = preload("res://scenes/level1.tscn")
		##file_name = "res://scenes/level1.tscn"
		#
	#if SaveInfo.continue_game:
		#print("slot", SaveInfo.slot)
		#print(file_name)
		#get_tree().change_scene_to_file(game_scene)
		##get_tree().change_scene_to_file("res://scenes/game.tscn")
#
	#elif SaveInfo.new_game:
		#print("STARTING NEW GAME")
		#print("slot", SaveInfo.slot)
		#DirAccess.remove_absolute(file_name)
		#print("DELETING", file_name)
		#get_tree().change_scene_to_file(file_name)
		##get_tree().change_scene_to_file("res://scenes/game.tscn")
#
##func menu_function():
	##if SaveInfo.continue_game:
		##print("continuing game")
	##else:
		##print("starting new game")
#
#
#func _on_back_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	#pass # Replace with function body.
#
#
#func _on_slot_1_pressed() -> void:
	##SaveInfo.slot = 1
	##print(SaveInfo.slot)
	##
	###call warning here
	##
	##DirAccess.remove_absolute("user://Gumm.save")
##
	##
	##get_tree().change_scene_to_packed(game_scene)
	#continue_or_start_game(1)
	#pass # Replace with function body.
#
#
#func _on_slot_2_pressed() -> void:
	##SaveInfo.slot = 2
	##print(SaveInfo.slot)
	##
	###call warning here
	##
	##DirAccess.remove_absolute("user://Gumm.save")
##
	##
	##get_tree().change_scene_to_packed(game_scene)
	#continue_or_start_game(2)
	#pass # Replace with function body.
#
#
#func _on_slot_3_pressed() -> void:
	##SaveInfo.slot = 3
	##print(SaveInfo.slot)
	##
	###call warning here
	##
	##DirAccess.remove_absolute("user://Gumm.save")
##
	##
	##get_tree().change_scene_to_packed(game_scene)
	#continue_or_start_game(3)
	#pass # Replace with function body.
#
#
#func _on_menu_function() -> void:
	#pass # Replace with function body.




#--------------------------------------------------------------------------------




extends Control

#const game_scene = preload("res://scenes/game.tscn")

var file_name
var savedData

signal menu_function

func _ready() -> void:
	
	#if SaveInfo.continue_game:
		#print("continuing game from slot")
	#else:
		#print("starting new game")
		
	#file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
		#
	#var savedGame = FileAccess.open(file_name, FileAccess.READ)
	##
	#var jsonString = savedGame.get_line()
	#var json = JSON.new()
	#json.parse(jsonString)
	#savedData = json.get_data()
	#
	
	pass # Replace with function body.

func continue_or_start_game(slot : int):
	
	file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
		
	var savedGame = FileAccess.open(file_name, FileAccess.READ)
	#
	var jsonString = savedGame.get_line()
	var json = JSON.new()
	json.parse(jsonString)
	savedData = json.get_data()
	
	SaveInfo.slot = slot
	
	if SaveInfo.continue_game:
		print("continuing game from slot")
	else:
		print("starting new game")

	if SaveInfo.continue_game:
		print("slot", SaveInfo.slot)
		print(file_name)
		#get_tree().change_scene_to_packed(game_scene)
		#get_tree().change_scene_to_file("res://scenes/level1.tscn")
		get_tree().change_scene_to_file("res://scenes/level" + str(savedData['level']) + ".tscn")

	elif SaveInfo.new_game:
		print("slot", SaveInfo.slot)
		DirAccess.remove_absolute(file_name)
		print(file_name)
		#get_tree().change_scene_to_packed(game_scene)
		#get_tree().change_scene_to_file("res://scenes/level1.tscn")
		get_tree().change_scene_to_file("res://scenes/level" + str(savedData['level']) + ".tscn")
		

#func menu_function():
	#if SaveInfo.continue_game:
		#print("continuing game")
	#else:
		#print("starting new game")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
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

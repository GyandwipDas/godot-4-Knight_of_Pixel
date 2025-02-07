extends Area2D
@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var entry_rock_animation_player_2: AnimationPlayer = $"../../Falling rocks/AnimationPlayer2"
@onready var cave_rocks_animation_player: AnimationPlayer = $"../../Falling rocks/AnimationPlayer"
@onready var memory_cutscene: Area2D = $"../../Memories/memory_cutscene1"
@onready var bridge_comb: Node2D = $"../../Bridge stuff/BridgeComb"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var dialogue_interaction = "../../Dialogues/dialogue_interaction"

@export var memory_count_update: bool = false
@export var memory_count: int = 0
@export var x_offset: int = 0
@export var memory_hider: int = 0



#var arr = String(get_path())
#var saveblocknum = str_to_var(arr[arr.length() - 2] + arr[arr.length() - 1]) if int(arr[arr.length() - 2]) else str_to_var(arr[arr.length() - 1])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#game_manager.loadGame() #might have to comment out?
	#if game_manager.nodeData["memory"] == memory_count:
		#self.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	#print(OS.get_user_data_dir())
	$"../../HUD/Score/debugger".text = OS.get_user_data_dir()
	var paths
	if area == character.area_2d:
		game_manager.loadGame()
		#if memory_count_update:
			#game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x + x_offset, character.position.y - 50), game_manager.nodeData["level"], memory_count)
		#else:
		#print("-->>", game_manager.nodeData)
		#print("SAVESLOT!:", SaveInfo.slot)
		print("This is save block-> ", get_path())
		game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x + x_offset, character.position.y - 50), game_manager.nodeData["level"], game_manager.nodeData["memory"], SaveInfo.slot)
		#if get_node(".") != get_node("../save_block8"):
			#game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x + x_offset, character.position.y - 50), game_manager.nodeData["level"], game_manager.nodeData["memory"], SaveInfo.slot)
			
		
		#deleting current and previous save blocks to stop accidentally saving previous postions
		animation_player.play("save_block")
		#print(get_path())
		var curr_path = String(get_path())
		var save_range: String
		
		#checks if the end of string "../save_block01" ends with either 1 or 2 integers to see if it is a ones place or tens place -_-`
		if int(curr_path[curr_path.length() - 1]) && int(curr_path[curr_path.length() - 2]): 
			save_range = curr_path[curr_path.length() - 2]
			save_range += curr_path[curr_path.length() - 1]
		elif int(curr_path[curr_path.length() - 1]):
			save_range = curr_path[curr_path.length() - 1]
			

		for i in range(1, int(save_range) + 1):
			paths = "../save_block" + str(i)
			game_manager.loadGame()
			
			#deletes future save blocks so you can interact with them only after 1st memory TBI
			if memory_count == 0 && save_range == "8" && game_manager.nodeData["memory"] != 1:
				#print("!!!!!!!!!!!!!!!!")
				#get_node("../save_block11").queue_free()
				get_node("../save_block11").collision_shape_2d.set_deferred("disabled", true)
			#elif memory_count == 0 && game_manager.nodeData["memory"] == 1 && save_range == "8":
				
				
			if get_node(paths) && paths != "../save_block8":
				##get_node(paths).queue_free()
				#print("Deleting saveblock: ", paths)
				get_node(paths).collision_shape_2d.set_deferred("disabled", true)
			#print(get_path()," -> ",get_node(paths))
			#get_node(paths).queue_free()
			
			#if paths == "../save_block12" && get_node("../save_block8"):
				#get_node("../save_block8").collision_shape_2d.set_deferred("disabled", true)
			
			#print("SAVE BLOCK->", i)
			if i >= 13:
				var path_to_plank6 = bridge_comb.get_child(5).get_child(5).get_path()
				#print("-->>", bridge_comb.get_child(5).get_children())
				bridge_comb.break_plank(6)
				bridge_comb.break_plank(7)
				#bridge_comb.get_child(5).get_child(5).queue_free()
				#bridge_comb.get_child(5).get_child(6).queue_free()
			pass
		
		game_manager.loadGame()
		var arr = String(get_path())
		var saveblocknum = str_to_var(arr[arr.length() - 2] + arr[arr.length() - 1]) if int(arr[arr.length() - 2]) else str_to_var(arr[arr.length() - 1])
		#print(saveblocknum, typeof(saveblocknum))
		#print(type_string(typeof(game_manager.nodeData["memory"])), "->", game_manager.nodeData["memory"])
		if ((game_manager.nodeData["memory"] == 1) && ((saveblocknum == 8) || (saveblocknum >= 12))):
			entry_rock_animation_player_2.play("end")
			cave_rocks_animation_player.play("RESET")
			if saveblocknum == 8:
				get_node("../save_block8").collision_shape_2d.set_deferred("disabled", true)
		#print(arr[arr.length() - 2], arr[arr.length() - 1])
		#print(saveblocknum, typeof(saveblocknum))
		#print(memory_count)
		if saveblocknum != 10 && str(game_manager.nodeData["memory"]) != "1":
			print("Mem col off")
			memory_cutscene.turnOffCollisionShape()
		elif saveblocknum == 10 && str(game_manager.nodeData["memory"]) != "1":
			print("Mem col on")
			memory_cutscene.turnOnCollisionShape()
		if saveblocknum == 13:
			print("Breaking bridge planks 6,7")
			bridge_comb.break_plank(6)
			bridge_comb.break_plank(7)
		else :
			pass
			
		#disabling dialogue boxes
		if saveblocknum >= 1 && get_node(dialogue_interaction + str(1)):
			get_node(dialogue_interaction + str(1)).collision_shape_2d.set_deferred("disabled", true)
		if saveblocknum >= 3 && get_node(dialogue_interaction + str(2)):
			get_node(dialogue_interaction + str(2)).collision_shape_2d.set_deferred("disabled", true)
		if saveblocknum >= 5 && get_node(dialogue_interaction + str(3)):
			get_node(dialogue_interaction + str(3)).collision_shape_2d.set_deferred("disabled", true)
		#print(get_path_to())
		
	pass # Replace with function body.

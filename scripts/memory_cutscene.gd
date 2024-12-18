extends Area2D

@onready var character: CharacterBody2D = $"../../character"
var memory_scene = preload("res://scenes/memory.tscn")
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var save_block_10: Area2D = $"../../Save blocks/save_block10"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	game_manager.loadGame()
	if game_manager.nodeData["memory"] > 0:
		#print("Deleting mem num1")
		for i in range(1, game_manager.nodeData["memory"] + 1):
			print("Deleting mem num2:", i)
			var paths = "../memory_cutscene" + str(i)
			#print("get_path->",get_path())
			print("get_path->", paths)
			if get_node(paths):
				get_node(paths).queue_free()
				print("Deleting mem num:",i)

#func _input(event: InputEvent) -> void:
	#if Input.is_key_pressed(KEY_F):
		#print("f key pressed")
		#turnOnCollisionShape()
		#
	#if Input.is_key_pressed(KEY_G):
		#print("g key pressed")
		#turnOffCollisionShape()

func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("Showing cutscene")
		get_tree().change_scene_to_file("res://scenes/memory.tscn")
		animation_player.play("memory_block")
		game_manager.loadGame()
		var arr = game_manager.nodeData["playerPos"]
		arr = arr.split(",")
		var arr1 = float(arr[0].split("(")[1])
		var arr2 = float(arr[1].split(")")[0])
		game_manager.saveGame(0,game_manager.nodeData["joystickType"], Vector2(arr1, arr2), game_manager.nodeData["level"], int(game_manager.nodeData["memory"])+1)
		#if game_manager.nodeData["memory"] > 0:
			#for i in range(0, game_manager.nodeData["memory"]):
				#var paths = "../memory_cutscene" + str(i)
				#if get_node(paths):
					#get_node(paths).queue_free()
					
func turnOnCollisionShape():
	print("ye")
	#collision_shape_2d.disabled = false
	collision_shape_2d.set_deferred("disabled", false)
	#animated_sprite_2d.visible = true
	animated_sprite_2d.set_deferred("visible", true)

func turnOffCollisionShape():
	print("ne")
	#collision_shape_2d.disabled = true
	collision_shape_2d.set_deferred("disabled", true)
	#animated_sprite_2d.visible = false
	animated_sprite_2d.set_deferred("visible", false)
	
	pass # Replace with function body.

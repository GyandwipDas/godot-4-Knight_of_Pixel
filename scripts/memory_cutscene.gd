extends Area2D

@onready var character: CharacterBody2D = $"../../character"
var memory_scene = preload("res://scenes/memory.tscn")
@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	game_manager.loadGame()
	if game_manager.nodeData["memory"] > 0:
		for i in range(1, game_manager.nodeData["memory"] + 1):
			var paths = "../memory_cutscene" + str(i)
			if get_node(paths):
				get_node(paths).queue_free()
			#print(i)

func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("Showing cutscene")
		get_tree().change_scene_to_file("res://scenes/memory.tscn")
		animation_player.play("memory_block")
		
		#if game_manager.nodeData["memory"] > 0:
			#for i in range(0, game_manager.nodeData["memory"]):
				#var paths = "../memory_cutscene" + str(i)
				#if get_node(paths):
					#get_node(paths).queue_free()
	pass # Replace with function body.

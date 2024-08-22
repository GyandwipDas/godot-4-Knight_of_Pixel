extends Area2D
@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var entry_rock_animation_player_2: AnimationPlayer = $"../../Falling rocks/AnimationPlayer2"
@onready var cave_rocks_animation_player: AnimationPlayer = $"../../Falling rocks/AnimationPlayer"

@export var memory_count_update: bool = false
@export var memory_count: int = 0
@export var x_offset: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#game_manager.loadGame()
	#if game_manager.nodeData["memory"] == memory_count:
		#self.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var paths
	if area == character.area_2d:
		#game_manager.loadGame()
		if memory_count_update:
			game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x + x_offset, character.position.y - 50), game_manager.nodeData["level"], memory_count)
		else:
			game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x + x_offset, character.position.y - 50), game_manager.nodeData["level"], game_manager.nodeData["memory"])
		
		#deleting current and previous save blocks to stop accidentally saving previous postions
		animation_player.play("save_block")
		print(get_path())
		var curr_path = String(get_path())
		
		for i in range(1, int(curr_path[curr_path.length() - 1])):
			paths = "../save_block" + str(i)
			#print(get_node(paths))
			if get_node(paths):
				get_node(paths).queue_free()
			#get_node(paths).queue_free()
			pass
		
		game_manager.loadGame()
		var arr = String(get_path())
		if game_manager.nodeData["memory"] == 1 && (arr[arr.length() - 1] == "9" || arr[arr.length() - 1] == "2"):
			entry_rock_animation_player_2.play("end")
			cave_rocks_animation_player.play("RESET")
	pass # Replace with function body.

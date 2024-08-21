extends Area2D
@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var save_block: Area2D = $"."
@onready var save_block_2: Area2D = $"../save_block2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		game_manager.loadGame()
		game_manager.saveGame(0, game_manager.nodeData["joystickType"], Vector2(character.position.x, character.position.y - 50), Vector2(character.position.x, character.position.y - 50))
		
		#deleting current and previous save blocks to stop accidentally saving previous postions
		animation_player.play("save_block")
		print(get_path())
		var curr_path = String(get_path())
		
		for i in range(1, int(curr_path[curr_path.length() - 1])):
			var paths = "../save_block" + str(i)
			print(get_node(paths))
			if get_node(paths):
				get_node(paths).queue_free()
			#get_node(paths).queue_free()
			pass
			
	pass # Replace with function body.

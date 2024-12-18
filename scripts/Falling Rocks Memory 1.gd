extends AnimationPlayer

@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.loadGame()
	#print("This is the memory count now", game_manager.nodeData["memory"])
	if int(game_manager.nodeData["memory"]) >= 1:
		#print("This is the memory count now!!!!", game_manager.nodeData["memory"])
		play("falling rocks")
	else:
		pause()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

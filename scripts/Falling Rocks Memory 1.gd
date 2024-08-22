extends AnimationPlayer

@onready var game_manager: Node = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.loadGame()
	if game_manager.nodeData["memory"] >= 1:
		play("falling rocks")
	else:
		pause()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#@tool
extends Area2D

@onready var sign_board: Sprite2D = $SignBoard

@export var rotateVal: String = "right"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match rotateVal:
		"u":
			sign_board.rotation_degrees = 90
			sign_board.position.y = 25
			sign_board.flip_h = true
		"d":
			sign_board.rotation_degrees = 90
			sign_board.position.y = 25
			sign_board.flip_h = false
		"l":
			sign_board.rotation_degrees = 0
			sign_board.position.y = 14
			sign_board.flip_h = true
		"r":
			sign_board.global_rotation = 0
			sign_board.position.y = 14
			sign_board.flip_h = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#match rotateVal:
		#"u":
			#sign_board.rotation_degrees = 90
			#sign_board.position.y = 25
			#sign_board.flip_h = true
		#"d":
			#sign_board.rotation_degrees = 90
			#sign_board.position.y = 25
			#sign_board.flip_h = false
		#"l":
			#sign_board.rotation_degrees = 0
			#sign_board.position.y = 14
			#sign_board.flip_h = true
		#"r":
			#sign_board.global_rotation = 0
			#sign_board.position.y = 14
			#sign_board.flip_h = false
	pass

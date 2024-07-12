extends Node2D

@onready var game_manager = %GameManager
@onready var sign = $Area2D
@onready var player = $Player
var playerPos: Vector2
var signPos: Vector2

# Called when the node enters the scene tree for the first time.
#func _ready():
	#game_manager.loadGame()
	#game_manager.switchJoystick()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerPos = player.position
	signPos = sign.position
	pass

func getPlayerPos():
	return playerPos

func getSignPos():
	return signPos
	
#func getSignPlayerPerc():
	#return 

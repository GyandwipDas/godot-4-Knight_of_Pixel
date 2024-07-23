extends Node2D

@onready var game_manager = %GameManager
@onready var sign = $Area2D
@onready var player = $Player
@onready var cat = $cat
@onready var camera = $Camera
@onready var camera_2d_cat = $cat/Camera2DCat
@onready var camera_2d_char = $Player/Camera2DChar

var playerPos: Vector2
var signPos: Vector2



# Called when the node enters the scene tree for the first time.
func _ready():
	camera.make_current()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	playerPos = player.position
	signPos = sign.position
	if game_manager.PlayerPOVCam == game_manager.Player.char:
		camera.global_position = cat.global_position
	else:
		camera.global_position = player.global_position
	pass

func getPlayerPos():
	return playerPos

func getSignPos():
	return signPos
	
#func getSignPlayerPerc():
	#return 

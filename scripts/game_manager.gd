extends Node

@onready var score_label = $"../HUD/Score/Score"
@onready var pause_menu = $"../HUD/PauseMenu"
@onready var joystick = $"../HUD/LeftUI/Joystick"
@onready var leftArrowInp = $"../HUD/LeftUI/LeftArrow"
@onready var rightArrowInp = $"../HUD/LeftUI/RightArrow"
@onready var arrow_jump = $"../HUD/RightUI/ArrowJump"
@onready var arrow_run = $"../HUD/RightUI/ArrowRun"
@onready var joystick_jump = $"../HUD/RightUI/JoystickJump"
@onready var camera = $"../Camera"
@onready var cat = $"../cat"
@onready var character = $"../character"

var score = 0
var paused = false #game state
var nodeData
enum Player { char, cat }
var PlayerPOVCam = Player.char
#var joystickType = false #true means joystick is stick type while false means arrow type `~`'

func save(score: int = 0, joystickType: bool = false, playerPos: Vector2 = Vector2(-221, -144), catPos: Vector2 = Vector2(-180, 2)):
	var saveDictionary = {
		"score" : score,
		"joystickType": joystickType,
		"playerPos": playerPos,
		"catPos": catPos,
	}
	return saveDictionary
	
func saveGame(score: int = 0, joystickType: bool = false, playerPos: Vector2 = Vector2(-221, -144), catPos: Vector2 = Vector2(-180, 2)):
	var saveGame = FileAccess.open("user://KnightOfPixel.save", FileAccess.WRITE)
	var jsonString = JSON.stringify(save(score, joystickType, playerPos, catPos))
	saveGame.store_line(jsonString)

func loadGame():
	if !FileAccess.file_exists("user://KnightOfPixel.save"):
		saveGame(0, true, Vector2(-221, -144), Vector2(-180, 2))
	var saveGame = FileAccess.open("user://KnightOfPixel.save", FileAccess.READ)
	
	while saveGame.get_position() < saveGame.get_length():
		var jsonString = saveGame.get_line()
		var json = JSON.new()
		var parseResult = json.parse(jsonString)
		nodeData = json.get_data()
		print("Loaded Data")

func add_coin(): 
	score += 1
	score_label.text = ": " + str(score)
	print(score)

func pauseGame():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func switchJoystick():
	loadGame()
	if !nodeData["joystickType"]:
		joystick.show()
		joystick_jump.show()
		leftArrowInp.hide()
		rightArrowInp.hide()
		arrow_jump.hide()
		arrow_run.hide()
		print("now stick type")
	elif nodeData["joystickType"]:
		joystick.hide()
		joystick_jump.hide()
		leftArrowInp.show()
		rightArrowInp.show()
		arrow_jump.show()
		arrow_run.show()
		print("now arrow type")
	saveGame(0,!nodeData["joystickType"], Vector2(-221, -144), Vector2(-180, 2))

func loadJoystick():
	loadGame()
	if nodeData["joystickType"]:
		joystick.show()
		joystick_jump.show()
		#leftArrowInp.hide()
		#rightArrowInp.hide()
		print("now stick type")
	elif !nodeData["joystickType"]:
		#joystick.hide()
		leftArrowInp.show()
		rightArrowInp.show()
		arrow_jump.show()
		arrow_run.show()
		print("now arrow type")
	saveGame(0,nodeData["joystickType"], Vector2(-221, -144), Vector2(-180, 2))

func _input(event):
	if event.is_action_pressed("pause"):
		print("Pause pressed")
		pauseGame()

func switchPlayerPOVCam():
	if PlayerPOVCam == Player.char:
		PlayerPOVCam = Player.cat
	elif PlayerPOVCam == Player.cat:
		PlayerPOVCam = Player.char
		pass
		
func distFromChar(from):
	if PlayerPOVCam == Player.char:
		return character.global_position.x - from.global_position.x
	else:
		return cat.global_position.x - from.global_position.x

func hintVisbility(from):
	var visibility = (120 - abs(distFromChar(from))) / 75
	#if visibility > 0 return visibility else return 0.00
	if visibility >= 0:
		return visibility
	else:
		return 0.00

func _physics_process(delta):
	#camera switch 
	if Input.is_action_just_pressed("switch"):
		switchPlayerPOVCam()
	if PlayerPOVCam == Player.char:
		camera.global_position = character.global_position
	else:
		camera.global_position = cat.global_position
	pass

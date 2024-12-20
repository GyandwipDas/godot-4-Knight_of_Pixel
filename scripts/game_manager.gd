extends Node

@onready var score_label = $"../HUD/Score/Score"
@onready var pause_menu = $"../HUD/PauseMenu"
@onready var joystick = $"../HUD/LeftUI/Joystick"
@onready var leftArrowInp = $"../HUD/LeftUI/LeftArrow"
@onready var rightArrowInp = $"../HUD/LeftUI/RightArrow"
@onready var arrow_jump = $"../HUD/RightUI/ArrowJump"
@onready var arrow_run = $"../HUD/RightUI/ArrowRun"
@onready var joystick_jump = $"../HUD/RightUI/JoystickJump"
@onready var cat = $"../cat"
@onready var character = $"../character"
@onready var camera = $"../Camera Stuff/Camera"
@onready var camera_3 = $"../Camera Stuff/Camera3"

var score = 0
var paused = false #game state
var nodeData
enum Player { char, cat }
var PlayerPOVCam = Player.char
var puzzle_pos
var falling = false
var is_cam_snapped = false
var file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"
#var joystickType = false #true means joystick is stick type while false means arrow type `~`'

func save(score: int = 0, joystickType: bool = false, playerPos: Vector2 = Vector2(-221, -144), level: int = 1, memory: int = 0):
	var saveDictionary = {
		"score" : score,
		"joystickType": joystickType,
		"playerPos": playerPos,
		"level": level,
		"memory": memory,
	}
	return saveDictionary
	
func saveGame(score: int = 0, joystickType: bool = false, playerPos: Vector2 = Vector2(-221, -144), level: int = 1, memory: int = 0):
	#print("saveGame")
	var savedGame = FileAccess.open(file_name, FileAccess.WRITE)
	var jsonString = JSON.stringify(save(score, joystickType, playerPos, level, memory))
	savedGame.store_line(jsonString)

func loadGame():
	if !FileAccess.file_exists(file_name):
		saveGame(0, true, Vector2(-436.2794, -10.07547), 1, 0)
		print("No saves found!")
	var saveGame = FileAccess.open(file_name, FileAccess.READ)
	
	while saveGame.get_position() < saveGame.get_length():
		var jsonString = saveGame.get_line()
		var json = JSON.new()
		json.parse(jsonString)
		nodeData = json.get_data()
		#print("Loaded Data", type_string(typeof(nodeData)))
		print("Loaded Data", nodeData)

func add_coin(): 
	score += 1
	score_label.text = ": " + str(score)
	print(score)

func pauseGame():
	if paused:
		pause_menu.hide()
		#Engine.time_scale = 1
		get_tree().paused = false
	else:
		pause_menu.show()
		#Engine.time_scale = 0
		get_tree().paused = true
	paused = !paused

func switchJoystick():
	var arr
	var arr1 : float
	var arr2 : float
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
		
	arr = nodeData["playerPos"]
	arr = arr.split(",")
	arr1 = float(arr[0].split("(")[1])
	arr2 = float(arr[1].split(")")[0])
	print("switchcontroller player pos -> ", arr1, " ", arr2)
	saveGame(0,!nodeData["joystickType"], Vector2(arr1, arr2), nodeData["level"], int(nodeData["memory"]))

func loadJoystick():
	var arr
	var arr1 : float
	var arr2 : float
	loadGame()
	if nodeData["joystickType"]:
		joystick.show()
		joystick_jump.show()
		#leftArrowInp.hide()
		#rightArrowInp.hide()
		#print("now stick type")
	elif !nodeData["joystickType"]:
		#joystick.hide()
		leftArrowInp.show()
		rightArrowInp.show()
		arrow_jump.show()
		arrow_run.show()
		#print("now arrow type")
		
	#converting the playerPos from string to float
	arr = nodeData["playerPos"]
	arr = arr.split(",")
	arr1 = float(arr[0].split("(")[1])
	arr2 = float(arr[1].split(")")[0])
	#print("load controller player pos -> ", arr1, " ", arr2)
	#saveGame(0,nodeData["joystickType"], Vector2(arr1, arr2), nodeData["level"], nodeData["memory"])

func _input(event):
	if event.is_action_pressed("pause"):
		#print("Pause pressed")
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
		
func parse_json(dialogue_json, dialogue_id):
	if FileAccess.file_exists(dialogue_json):
		#print("dialogue json", dialogue_json)
		var file = FileAccess.open(dialogue_json, FileAccess.READ)
		
		#var json_string = file.get_line()
		var json = JSON.new()
		json.parse(file.get_as_text())
		var json_text = json.get_data()
		#print("parsed data", json_text)
		return json_text[dialogue_id]

func _physics_process(delta):
	#camera switch 
	if Input.is_action_just_pressed("switch"):
		camera.make_current()
		switchPlayerPOVCam()
		
	#if Input.is_key_pressed(KEY_V):
		#print("K")
		
	#if puzzle_pos:		#handles puzzle scenes
		#camera.position_smoothing_speed = 1
		##print("! ", puzzle_pos)
		#camera.global_position = puzzle_pos
		
		
	if PlayerPOVCam == Player.char:
		camera.position_smoothing_speed = 3.5 if is_cam_snapped else 10
		camera.position_smoothing_enabled = true if is_cam_snapped else false
		camera.global_position = character.global_position + Vector2(0, -15)
		#print(camera.position_smoothing_speed, " ", camera.position_smoothing_enabled)
		#camera_3.global_position = character.global_position + Vector2(0, -15)
	if PlayerPOVCam == Player.cat:
		camera.position_smoothing_speed = 4
		camera.global_position = cat.global_position + Vector2(0, -15)
		#camera_3.global_position = character.global_position + Vector2(0, -15)
		pass
	if puzzle_pos:		#handles puzzle scenes
		camera.position_smoothing_speed = 1
		#print("! ", puzzle_pos)
		camera.global_position = puzzle_pos
		pass
	if falling:
		camera.position_smoothing_speed = 20
		pass

	pass 


func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	is_cam_snapped = true
	camera.position_smoothing_enabled = true
	#print("snapped")

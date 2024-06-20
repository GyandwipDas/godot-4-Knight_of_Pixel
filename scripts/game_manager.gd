extends Node

@onready var score_label = $"../HUD/Score/Score"
@onready var pause_menu = $"../HUD/PauseMenu"
@onready var joystick = $"../HUD/LeftStick/Joystick"
@onready var leftArrowInp = $"../HUD/LeftStick/TouchScreenButton"
@onready var rightArrowInp = $"../HUD/LeftStick/TouchScreenButton2"

var score = 0
var paused = false
var joystickType = false #true means joystick is stick type while false means arrow type `~`'

func add_coin(): 
	score += 1
	score_label.text = ": " + str(score)
	print(score)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		print("Pause pressed")
		pauseGame()

func pauseGame():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	
func switchJoystick():
	if joystickType:
		joystick.show()
		leftArrowInp.hide()
		rightArrowInp.hide()
		joystickType = false
		print("now stick type")
	elif !joystickType:
		joystick.hide()
		leftArrowInp.show()
		rightArrowInp.show()
		joystickType = true
		print("now arrow type")
		

extends Node

@onready var score_label = $"../HUD/Score/Score"
@onready var pause_menu = $"../HUD/PauseMenu"

var score = 0
var paused = false

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

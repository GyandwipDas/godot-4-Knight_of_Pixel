extends Node
#@onready var score_label = $"../Player/Camera2D/Score"
@onready var score_label = $"../Player/Score"

var score = 0

func add_coin(): 
	score += 1
	score_label.text = "🪙: " + str(score)
	print(score)

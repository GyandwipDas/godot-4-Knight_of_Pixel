extends Area2D
@onready var game = $".."
@onready var game_manager = %GameManager
@onready var label = $AnimatedSprite2D/Label
@export var labelstring = ""

# Change this to _ready before shipping
func _process(delta):
	label.text = labelstring
	#print(game_manager.hintVisbility(self))
	#label.visible_ratio = game_manager.hintVisbility(self)
	label.modulate = Color(1.0, 1.0, 1.0, game_manager.hintVisbility(self))

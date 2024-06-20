extends Control
@onready var game_manager = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	game_manager.pauseGame()


func _on_quit_pressed():
	get_tree().quit()


func _on_controller_type_pressed():
	game_manager.switchJoystick()

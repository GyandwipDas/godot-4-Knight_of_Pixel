extends HBoxContainer
@onready var game_manager = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.loadJoystick()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Area2D
@onready var camera = $"../Camera"
@onready var camera_2 = $"../Camera2"
@onready var cat = $"../../cat"
@onready var character = $"../../character"
@onready var camera_3: Camera2D = $"../Camera3"
@onready var timer: Timer = $Timer
@onready var game_manager: Node = %GameManager

#@export var posX:float
#@export var posY:float
#@export var zoom:float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(camera.position)
	pass
	
func _on_body_entered(body):
	var tween = create_tween()
	if body == character || body == cat:
		#camera_3.position = camera.position
		#camera_3.make_current()
		#tween.set_parallel()
		#tween.tween_property(camera_3, "position", camera_2.position, 2)
		tween.tween_property(camera, "zoom", Vector2(3,3), 1.5)
		
		character.inputs_allowed = false
		timer.start()
	game_manager.puzzle_pos = camera_2.position
	print(camera_2.position)
	pass


func _on_body_exited(body):
	var tween = create_tween()
	if body == character || body == cat:
		#tween.set_parallel()
		#camera.position_smoothing_enabled = false
		tween.tween_property(camera, "zoom", Vector2(4,4), 1.5)
		#tween.tween_property(camera_3, "position", camera.position, 1)
		##if !tween.:
			##camera.make_current()
		##camera.make_current()
		
		character.inputs_allowed = false
		timer.start()
		
	game_manager.puzzle_pos = null
	#print(camera_2.position)
	pass


func _on_timer_timeout() -> void:
	#print("switched to cam1")
	#camera.make_current()
	camera.position_smoothing_speed = 2
	character.inputs_allowed = true
	
	
	pass # Replace with function body.

extends Area2D
@onready var camera = $"../Camera"
@onready var camera_2 = $"../Camera2"
@onready var cat = $"../../cat"
@onready var character = $"../../character"

@export var posX:float
@export var posY:float
@export var zoom:float
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
		camera_2.make_current()
	pass


func _on_body_exited(body):
	if body == character || body == cat:
		camera.make_current()
	pass

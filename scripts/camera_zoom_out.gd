extends Area2D
@onready var character = $"../character"
@onready var camera = $"../Camera"

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
	#var tween = create_tween()
	#if body == character:
		##print(camera.zoom," ", camera.position)
		#tween.tween_property(camera, "zoom", Vector2(zoom, zoom), 1)
	pass

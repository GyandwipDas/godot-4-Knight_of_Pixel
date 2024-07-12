extends Node2D

const SPEED = 70
var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1 
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() :
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta
	pass

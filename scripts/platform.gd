extends AnimatableBody2D
@onready var sprite_2d = $Sprite2D
@onready var character = $"../../character"
@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer
@onready var animation_player = $"../long_platform2/AnimationPlayer"

@export var type: String
@export var moveable: bool
@export var moveWhenOn: bool
@export var waitTime = 1.0
@onready var playerOnPF = false
var x
var y
var w
var h
var sx

var playFW = true #play animation forward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = waitTime
	match type[0]:
		"s" :
			x = 0					#FIRST TILE X = 0, Y = 0, W = 16, H = 10
			w = 16										#+16
			h = 10
			sx = .5
		"m" :
			x = 16					#FIRST TILE X = 16, Y = 0, W = 32, H = 10
			w = 32										#+16
			h = 10
			sx = 1
		"l" :
			x = 48					#FIRST TILE X = 48, Y = 0, W = 48, H = 10
			w = 48										#+16
			h = 10
			sx = 1.5
	
	match type[1]:
		"0" :
			y = 0
		"1" :
			y = 16
		"2" :
			y = 32
		"3" :
			y = 48
	sprite_2d.region_rect = Rect2(x, y, w, h)
	collision_shape_2d.scale = Vector2(sx, 1)
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	playerOnPF = true
	if moveable:
		if !moveWhenOn:
			get_child(5).play("RESET")
		else:
			playFW = true
			timer.start()


func _on_area_2d_area_exited(area):
	playerOnPF = false
	if moveable:
		if !moveWhenOn:
			get_child(5).play("new_animation")
		else:
			playFW = false
			timer.start()

func _on_timer_timeout():
	if playFW == true && playerOnPF == true:
		get_child(5).play("new_animation")
	elif playFW == false && playerOnPF == false:
		get_child(5).play_backwards("new_animation")
	pass # Replace with function body.


func _on_timer_2_timeout():
	pass # Replace with function body.

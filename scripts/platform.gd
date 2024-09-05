extends AnimatableBody2D
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var entry_timer = $Entry_Timer
@onready var return_timer = $Return_Timer
@onready var collision_shape_detector = $Area2D/CollisionShape2D
@onready var character: CharacterBody2D = $"../../../character"

@export var type: String
@export var moveable : bool
@export var moveWhenOn: bool
@export var waitTime = 1.0
@export var returnable: bool
@export var continuous_play: bool
@export var one_way_col: bool = true

var x
var y
var w
var h
var px # platform x dimension
var dx # detector x dimension

var playFW = true #play animation forward = true

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_shape_2d.one_way_collision = one_way_col
	entry_timer.wait_time = waitTime
	return_timer.wait_time = waitTime + 1
	#var player = get_node(get_child(5))
	#animation_player.play_backwards()
	
	#dynamic block selector
	match type[0]:
		"s" :
			x = 0			#FIRST TILE X = 0, Y = 0, W = 16, H = 10
			w = 16								#+16
			h = 10
			px = .5
			dx = 1.45
		"m" :
			x = 16			#FIRST TILE X = 16, Y = 0, W = 32, H = 10
			w = 32								#+16
			h = 10
			px = 1
			dx = 2.85
		"l" :
			x = 48			#FIRST TILE X = 48, Y = 0, W = 48, H = 10
			w = 48								#+16
			h = 10
			px = 1.5
			dx = 4.25
	
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
	collision_shape_2d.scale = Vector2(px, 1)
	collision_shape_detector.scale = Vector2(dx, 1)
	
	if continuous_play:
		get_parent().play("platform")
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if moveable:
		if !moveWhenOn:
			#get_child(5).play("RESET")
			get_child(5).active = false
		else:
			entry_timer.start()
			

func _on_area_2d_area_exited(area):
	if moveable:
		if !moveWhenOn:
			get_child(5).active = true
			get_child(5).play("new_animation")
		else:
			entry_timer.stop()
			

#func _on_timer_timeout():
	#if playFW == true:
		#get_child(5).play("new_animation")
	#elif playFW == false:
		#get_child(5).play_backwards("new_animation")
	#pass # Replace with function body.


func _on_entry_timer_timeout():
	if playFW:
		get_child(5).play("new_animation")
		if returnable:
			return_timer.start()
		else:
			playFW = false
	else:
		get_child(5).play_backwards("new_animation")
		playFW = true
	pass

func _on_return_timer_timeout():
	get_child(5).play_backwards("new_animation")
	pass # Replace with function body.

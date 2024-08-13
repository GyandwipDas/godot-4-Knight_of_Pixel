extends AnimatableBody2D
@onready var sprite_2d = $Sprite2D
@onready var character = $"../../character"
@onready var collision_shape_2d = $CollisionShape2D
@export var platform:int 
@onready var pf_string = "../platform" + str(platform) + "/AnimationPlayer"
#$"../platform6/AnimationPlayer"
@onready var animation_player = $"../platform$platform/AnimationPlayer"

@export var type: String
var x
var y
var w
var h
var sx
# Called when the node enters the scene tree for the first time.
func _ready():
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
	if platform:
		get_child(3).play("RESET")


func _on_area_2d_area_exited(area):
	if platform:
		get_child(3).play("new_animation")

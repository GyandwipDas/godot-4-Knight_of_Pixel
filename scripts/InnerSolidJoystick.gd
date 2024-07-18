extends Sprite2D

var pressing = false
@onready var parent = $".."
@onready var outer_ring_joystick = $"../OuterRingJoystick"
@onready var maxLength = 135
@onready var deadzone = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	maxLength += parent.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#maxLength += parent.scale.x
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
			outer_ring_joystick.skew = 0
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle)*maxLength
			global_position.y = parent.global_position.y + sin(angle)*maxLength
			#skew outer ring
			outer_ring_joystick.skew = 10
			outer_ring_joystick.rotation = angle - 15.15
		calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta*50)
		outer_ring_joystick.skew = 0
		parent.posVector = Vector2(0,0)

func calculateVector():
	if abs(global_position.x - parent.global_position.x) >= deadzone:
		parent.posVector.x = (global_position.x - parent.global_position.x)/maxLength
		#print(parent.posVector.x)
	if abs(global_position.y - parent.global_position.y) >= deadzone:
		parent.posVector.y = (global_position.y - parent.global_position.y)/maxLength
		
	if abs(global_position.x - parent.global_position.x) <= deadzone:
		parent.posVector.x = 0

func _on_button_button_down():
	pressing = true
	parent.pressing = true

func _on_button_button_up():
	pressing = false
	parent.pressing = false

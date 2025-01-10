extends Node2D

#$"planks/Bridge plank1/bridge_plank_area"
@onready var bridge_plank_area_3: Area2D = $"planks/Bridge plank3/bridge_plank_area3"
@onready var character: CharacterBody2D = $"../../character"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#func break_planks(break_plank_num1, break_plank_num2):
	#var break_plank_pin_path = "planks/Bridge plank7/PinJoint2D" + 
	
func break_plank(plank : int):
	var plank_string_path = "planks/Bridge plank" + str(plank) + "/bridge_plank_area" + str(plank)
	#var plank_string_path = "planks/Bridge plank1/bridge_plank_area"
	#var plank_path = $plank_string_path
	if get_node(plank_string_path):
		print("breaking plank: ", plank)
		#print("plank to break->", plank_string_path)
		get_node(plank_string_path).start_first_pin_timer()

func break_bridge_segment(num):
	#$"Bridge Segments/PinJoint2D2"
	var pin_joint_path = "Bridge Segments/PinJoint2D" + num
	#print(pin_joint_path)
	get_node(pin_joint_path).node_a = ""
	get_node(pin_joint_path).node_b = ""
	
	

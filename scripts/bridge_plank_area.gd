extends Area2D
@onready var character: CharacterBody2D = $"../../../../../character"
@onready var first_pin_timer: Timer = $"first pin timer"
@onready var second_pin_timer: Timer = $"second pin timer"
@onready var delete_timer: Timer = $"delete timer"



func _on_area_entered(area: Area2D) -> void:
	var plank_parent: String = get_parent().get_path()
	var plank_parent_num = plank_parent[plank_parent.length()-1] 
	
	#breaking plank 4 when on plank 3
	if area == character.area_2d && plank_parent_num == "3":
		get_node(plank_parent).get_parent().get_parent().break_plank(4)
	
	#breaking planks 9, 10, 11 when lands on plank 8
	#var plank_parent: String = get_parent().get_path()
	#var plank_parent_num = plank_parent[plank_parent.length()-1] 
	if area == character.area_2d && plank_parent_num == "8":
		get_node(plank_parent).get_parent().get_parent().break_plank(9)
		get_node(plank_parent).get_parent().get_parent().break_plank(10)
		get_node(plank_parent).get_parent().get_parent().break_plank(11)
		get_node(plank_parent).get_parent().get_parent().break_bridge_segment("32")
		Engine.time_scale = .5

	
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		#print("Left pin ", get_parent().get_child(2), "\nRight pin ", get_parent().get_child(3))
		start_first_pin_timer()
		#first_pin_timer.start()
		
	#breaking planks 9, 10, 11 when lands on jumps from plank 8
	#var plank_parent: String = get_parent().get_path()
	#var plank_parent_num = plank_parent[plank_parent.length()-1] 
	#if area == character.area_2d && plank_parent_num == "8":
		#get_node(plank_parent).get_parent().get_parent().break_plank(9)
		#get_node(plank_parent).get_parent().get_parent().break_plank(10)
		#get_node(plank_parent).get_parent().get_parent().break_plank(11)
		#get_node(plank_parent).get_parent().get_parent().break_bridge_segment("32")
		
	
	pass # Replace with function body.


func _on_first_pin_timer_timeout() -> void:
	#get_parent().get_child(2).set_node_a("")
	#get_parent().get_child(2).set_node_b("")
	#second_pin_timer.start()
	start_first_pin_timer()
	pass # Replace with function body.


func _on_second_pin_timer_timeout() -> void:
	get_parent().get_child(3).set_node_a("")
	get_parent().get_child(3).set_node_b("")
	#print("pin B disabled!")
	delete_timer.start()
	pass # Replace with function body.


func _on_delete_timer_timeout() -> void:
	get_parent().queue_free()
	pass # Replace with function body.

func start_first_pin_timer():
	get_parent().get_child(2).set_node_a("")
	get_parent().get_child(2).set_node_b("")
	#print("pin A disabled!")
	second_pin_timer.start()

extends AnimatedSprite2D

@onready var character: CharacterBody2D = $"../character"

var inner_area_entered = false
var outer_area_entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inner_area_entered && !outer_area_entered:
		play("kick")
	elif outer_area_entered && !inner_area_entered:
		play("look back")
	else:
		play("idle")
	pass
	

#func _on_outer_area_area_entered(area: Area2D) -> void:
	#if area == character.area_2d:
		#print("outer area entered")
		##play("look back")
		#outer_area_entered = true
	#pass # Replace with function body.
#
#
#func _on_inner_area_area_entered(area: Area2D) -> void:
	#if area == character.area_2d:
		#print("inner area entered")
		##play("kick")
		#inner_area_entered = true
	#pass # Replace with function body.
#
#
#func _on_inner_area_area_exited(area: Area2D) -> void:
	#if area == character.area_2d:
		#print("inner area exited")
		#inner_area_entered = false
	#pass # Replace with function body.
#
#
#func _on_outer_area_area_exited(area: Area2D) -> void:
	#if area == character.area_2d:
		#outer_area_entered = false
		#print("outer area exited")
	#pass # Replace with function body.


func _on_r_inner_area_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = true
		print("r inner area entered")
		inner_area_entered = true
	pass # Replace with function body.


func _on_r_inner_area_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = true
		print("r inner area exited")
		inner_area_entered = false
	pass # Replace with function body.


func _on_r_outer_area_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = true
		print("r outer area entered")
		outer_area_entered = true
	pass # Replace with function body.


func _on_r_outer_area_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = true
		print("r outer area exited")
		outer_area_entered = false
	pass # Replace with function body.


func _on_l_inner_area_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = false
		print("l inner area entered")
		inner_area_entered = true
	pass # Replace with function body.


func _on_l_inner_area_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = false
		print("l inner area exited")
		inner_area_entered = false
	pass # Replace with function body.


func _on_l_outer_area_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = false
		print("l outer area entered")
		outer_area_entered = true
	pass # Replace with function body.


func _on_l_outer_area_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		flip_h = false
		print("l outer area exited")
		outer_area_entered = false
	pass # Replace with function body.

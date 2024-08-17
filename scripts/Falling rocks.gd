@tool
extends Node2D
@onready var sprite_2d = $Sprite2D


#	0 	0 	16 	16
#	+16
#@onready var rock_types: Array[Vector2i]
@onready var rock_types: Array[Rect2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#creating 4x2 matrix vector2 of all possible rock sprites :p
	var r = 0
	var c = 0
	for i in range (2):
		for j in range (4):
			rock_types.append(Rect2i(r,c, 16, 16))
			r += 16
		c += 16
		r = 0
	var rand_index = randi() % rock_types.size()
	print(rand_index)
	sprite_2d.region_rect = rock_types[rand_index]

#func _input(event):
	#var rand_index = randi() % rock_types.size()
	##sprite_2d.region_rect = randomize()
	#if Input.is_key_pressed(KEY_K):
		#print(rock_types[rand])

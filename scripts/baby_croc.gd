extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var character: CharacterBody2D = $"../.."
@onready var timer: Timer = $Timer

var rand_sprite
var rand_anim_start
var rand_speed

func _ready() -> void:
	rand_sprite = randi() % 2
	rand_anim_start = randf_range(0.0, 1.0)
	rand_speed = randf_range(1.0, 2.0)
	#if rand_sprite == 0:
		#animated_sprite_2d.play("on_belly")
	#else:
		#animated_sprite_2d.play("on_back")
	timer.start(rand_anim_start)
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print("dead")
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	animated_sprite_2d.speed_scale = rand_speed
	if rand_sprite == 0:
		animated_sprite_2d.play("on_belly")
	else:
		animated_sprite_2d.play("on_back")
	pass # Replace with function body.

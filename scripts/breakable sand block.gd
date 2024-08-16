extends AnimatableBody2D

@onready var character = $"../character"
@onready var cat = $"../cat"
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimatedSprite2D/AnimationPlayer
@onready var timer = $Timer
@onready var return_timer = $ReturnTimer
@onready var collision_shape_2d = $CollisionShape2D

@export var waitTime:float
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = waitTime
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	timer.start()
	pass # Replace with function body.
	


func _on_timer_timeout():
	animated_sprite_2d.play("break")
	animation_player.play("break")
	
	#self.queue_free()
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	timer.stop()
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	collision_shape_2d.disabled = true
	print("block deleted")
	return_timer.start()
	pass # Replace with function body.

func _on_return_timer_timeout():
	print("Came back")
	collision_shape_2d.disabled = false
	animated_sprite_2d.play_backwards("break")
	pass # Replace with function body.

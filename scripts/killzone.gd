extends Area2D
@onready var player = $"../Player"

@onready var timer = $Timer

func _on_body_entered(body):
	if body == player:
		print("char")
	print("Player Died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()	
	

func _on_timer_timeout():
	print("Restarting game")
	Engine.time_scale = 1
	get_tree().reload_current_scene()

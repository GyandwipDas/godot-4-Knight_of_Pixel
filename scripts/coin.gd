extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	print("+1 Coin")
	game_manager.add_coin() 
	animation_player.play("PickupAnimation")
	#queue_free()
	pass # Replace with function body.

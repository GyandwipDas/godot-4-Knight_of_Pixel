extends Area2D

@onready var animation_player: AnimationPlayer = $".."
@onready var player: CharacterBody2D = $"../../../character"
@onready var timer: Timer = $Timer

@export var anim_to_play: String
@export var pause_player_time: float = 0.0
@export var action_to_sim: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == player.area_2d:
		if pause_player_time == 0.0:
			print("Playing ", anim_to_play)
			animation_player.play(anim_to_play)
		else:
			player.inputs_allowed = false
			animation_player.play(anim_to_play)
			print("disabled ctrls")
			timer.start(pause_player_time)
			Input.action_press(action_to_sim)
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	queue_free()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	Input.action_release(action_to_sim)
	player.inputs_allowed = true
	print("enabled ctrls")
	queue_free()
	pass # Replace with function body.

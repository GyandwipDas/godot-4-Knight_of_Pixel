extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $SignBoard/AnimationPlayer
@export var rotate_direction: String = "r" # can be r, l, ru, rd, lu, ld

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_player.active = false
	match rotate_direction:
		"r" : animation_player.play("rotate_right")
		"ru" : animation_player.play("rotate_right_up")
		"rd" : animation_player.play("rotate_right_down")
		"l" : animation_player.play("rotate_left")
		"lu" : animation_player.play("rotate_left_up")
		"ld" : animation_player.play("rotate_left_down")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	animation_player.active = true
	match rotate_direction:
		"r" : animation_player.play("rotate_right")
		"ru" : animation_player.play("rotate_right_up")
		"rd" : animation_player.play("rotate_right_down")
		"l" : animation_player.play("rotate_left")
		"lu" : animation_player.play("rotate_left_up")
		"ld" : animation_player.play("rotate_left_down")
	pass # Replace with function body.

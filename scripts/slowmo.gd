extends Area2D
@onready var character: CharacterBody2D = $"../../../character"
@onready var animation_player: AnimationPlayer = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d && animation_player.is_playing():
		character.slowmospeed()
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		character.normalspeed()
	pass # Replace with function body.

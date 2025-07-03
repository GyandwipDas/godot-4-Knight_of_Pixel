extends Area2D

@onready var croc: CharacterBody2D = $"../1st Croc"
@onready var character: CharacterBody2D = $"../character"
@onready var timer_2: Timer = $"../1st Croc/Timer2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_exited(area: Area2D) -> void:
	if area == character.area_2d:
		timer_2.start(5)
	pass # Replace with function body.


func _on_timer_2_timeout() -> void:
	croc.queue_free()
	queue_free()
	pass # Replace with function body.

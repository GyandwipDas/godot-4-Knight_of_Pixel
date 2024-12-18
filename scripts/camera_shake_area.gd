extends Area2D
@onready var character: CharacterBody2D = $"../../character"
@onready var camera: Camera2D = $"../Camera"
	
@export var intensity = 100
@export var duration = 1
@export var start_time = 0

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var decreaser = (duration - (Time.get_ticks_msec() - start_time)) / duration
	
	var rand_x = rng.randf_range(-1, 1) * intensity * decreaser
	var rand_y = rng.randf_range(-1, 1) * intensity * decreaser
	
	camera.offset = Vector2(rand_x, rand_y)
	
	if decreaser < 0:
		camera.offset =  Vector2.ZERO
		set_process(false)
		
func shake_camera(intensity = 1.0, duration = 1.0):
	intensity = float(intensity)
	duration = float(duration * 1000)
	start_time = Time.get_ticks_msec()
	
	set_process(true)


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		#shake_camera()
		#character.slowmospeed()
		pass
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	#character.normalspeed()
	pass # Replace with function body.

extends GPUParticles2D


@export var life_time = 10
@export var preprocess_time = 20
@export var draw_x = -10000
@export var draw_y = -10000
@export var draw_w = -10000
@export var draw_h = -10000
@export var turb_noise_strength = 0.1
@export var turb_noise_scale = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_timer():
	lifetime = 10

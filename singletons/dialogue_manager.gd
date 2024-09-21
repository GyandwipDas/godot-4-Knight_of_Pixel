extends Node

@onready var dialogue_box_scene = preload("res://scenes/dialogue_box.tscn")
#@onready var character: CharacterBody2D = $character

var dialogue_lines: Array[String] = []
var current_line_index = 0

var dialogue_box
var dialogue_box_position: Vector2

var is_dialogue_active = false
var can_advance_dialogue = false

var talker1 = null

func start_dialogue(position: Vector2, lines: Array[String], character: CharacterBody2D):
	if is_dialogue_active:
		return
	
	dialogue_box_position = position
	dialogue_lines = lines
	talker1 = character
	_show_dialogue_box()
	
	is_dialogue_active = true
	

func _show_dialogue_box():
	talker1.inputs_allowed = false
	dialogue_box = dialogue_box_scene.instantiate()
	dialogue_box.connect(_on_text_finished_displaying)
	get_tree().root.add_child(dialogue_box)
	dialogue_box.global_position = dialogue_box_position
	dialogue_box.display_text(dialogue_lines[current_line_index])
	can_advance_dialogue = false
	

func _on_text_finished_displaying():
	can_advance_dialogue = true


func _unhandled_input(event: InputEvent) -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(func(): talker1.inputs_allowed = true)
	if (
		event.is_action_pressed("char_jump") && 
		is_dialogue_active && 
		can_advance_dialogue
		):
		dialogue_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			timer.start(.5)
			#dialogue_box.letter_display_timer.start(dialogue_box.dialogue_end_time)
			return
		_show_dialogue_box()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

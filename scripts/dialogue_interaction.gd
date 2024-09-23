extends Area2D

@onready var character: CharacterBody2D = $"../../character"
@onready var dialogue_box_3: MarginContainer = $"../dialogue_box_3"

@export var dialogue_id: String = ""
@export var talkers: Array[String] = ["player"]
@export var dialogue_y_offset = 24
@export var dialogue_x_offset = 0

const lines: Array[String] = [
	"I'm [wave]hungry!",
	"Better find something to eat quick",
	"Lets look around for something"
]
var area_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		#print("Talking")
		#SignalBus.emit_signal("display_dialogue", dialogue_key)
		dialogue_box_3.start_dialogue(dialogue_id, dialogue_y_offset, dialogue_x_offset)
		area_active = true
		#await DialogueManager.start_dialogue(character.position, lines, character)
		#pass
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("char_jump") && area_active:
		dialogue_box_3.start_dialogue(dialogue_id, dialogue_y_offset, dialogue_x_offset)
		if dialogue_box_3.finished:
			character.inputs_allowed = true
			queue_free()
		#DialogueManager.start_dialogue(character.position, lines)
		#SignalBus.emit_signal("display_dialogue", dialogue_key)
		pass
	pass


func _on_area_exited(area: Area2D) -> void:
	area_active = false
	dialogue_box_3.visible = false
	#queue_free()
	#character.inputs_allowed = true

func delete_dialogue_box():
	print("deleting dialogue box", get_node(get_path()))
	get_node(get_path()).queue_free()

	pass # Replace with function body.

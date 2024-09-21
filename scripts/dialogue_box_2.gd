extends MarginContainer
@onready var character: CharacterBody2D = $"../../character"
@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel
@export_file("*.json") var dialogue_json

var scene_text = {}
var selected_text = []
var in_progress = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	scene_text = load_dialogue_json_to_text()
	#print(scene_text)
	SignalBus.connect("display_dialogue", Callable(self, "on_display_dialogue"))
	
	pass # Replace with function body.

func load_dialogue_json_to_text():
	if FileAccess.file_exists(dialogue_json):
		var file = FileAccess.open(dialogue_json, FileAccess.READ)
		var json_to_text = JSON.new()
		json_to_text.parse(file.get_as_text())
		#print(json_to_text)
		return json_to_text.get_data()
	pass
	
func show_text():
	rich_text_label.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	rich_text_label.text = ""
	visible = false
	in_progress = false
	print("finished dialogue ")
	await get_tree().create_timer(1).timeout
	character.inputs_allowed = true

func on_display_dialogue(text_key):
	character.inputs_allowed = false
	if in_progress:
		next_line()
	else:
		position = character.position 
		position.y += -25
		visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

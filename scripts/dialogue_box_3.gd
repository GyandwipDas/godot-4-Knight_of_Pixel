extends MarginContainer
@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"
@onready var cat: CharacterBody2D = $"../../cat"
@onready var npc1: Sprite2D = $"../../Enemies/Sprite2D"
@onready var rich_text_label_2: RichTextLabel = $MarginContainer/RichTextLabel2
@onready var dialogue_interaction_3: Area2D = $"../dialogue_interaction3"


@export_file("*json") var dialogue_json
#@export var dialogue_id: String 
#@export var talkers: Array[String] = ["player"]

var talker_1_pos 
var talker_2_pos
var json_text
var MAX_WIDTH 
var in_progress = false
var dialogue_progress = 0 #no. of the dialogue in sequence
var dialogues # full set of dialogues
var dialogue_line #the full string of dialogue from sequence
var special_string #string of characters that have a rich text effect
var finished = false
var y_offset 
var x_offset

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_dialogue(dialogue_id, dialogue_y_offset, dialogye_x_offset):
	finished = false
	y_offset = dialogue_y_offset
	x_offset = dialogye_x_offset
	rich_text_label_2.text = ""
	character.inputs_allowed = false
	dialogues = game_manager.parse_json(dialogue_json, dialogue_id)

	if in_progress:
		next_line()
	else:
		in_progress = true
		show_text()

func next_line():
	if dialogue_progress == dialogues.size() - 1:
		finish()
	else:
		dialogue_progress += 1
		show_text()
		#print(dialogue_progress, "out of", dialogues.size()-1)
	
func show_text():
	rich_text_label_2.text = ""
	var tween = create_tween()
	visible = true
	rich_text_label_2.visible_ratio = 0
	#print("dialog prog: ", dialogue_progress)
	match dialogues[dialogue_progress]["character"]:
		"player": 
			position = character.position
		"npc1": 
			position = npc1.position 
		_:
			print("ERROR in finding talker")
	global_position.x -= size.x/4 + x_offset
	global_position.y -= size.y/4 + y_offset
	rich_text_label_2.text = dialogues[dialogue_progress]["dialogue"]
	#print(dialogues[dialogue_progress]["dialogue"])
	tween.tween_property(rich_text_label_2, "visible_ratio", 1, 1)
	
func finish():
	#character.inputs_allowed = true
	#print("Finished!")
	in_progress = false
	dialogue_progress = 0
	rich_text_label_2.text = ""
	#print("dialog prog reset")
	#dialogue_interaction_3.delete_dialogue_box()
	visible = false
	finished = true
	pass

extends MarginContainer

@onready var label: Label = $MarginContainer/Label
@onready var letter_display_timer: Timer = $"Letter Display Timer"
@onready var character: CharacterBody2D = $character
@onready var rich_text_label: RichTextLabel = $MarginContainer/Label/RichTextLabel

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_time = .03 #.03
var punctuation_time = .02 #.02
var space_time = .1 #.05
var dialogue_end_time = .1

var dialogue_end = false

signal finished_displaying()

func display_text(text_to_disp: String):
	text = text_to_disp
	rich_text_label.text = text
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		rich_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x/2
	global_position.y -= size.y/2 + 24
	
	rich_text_label.text =""
	_display_letter()
	
	
func _display_letter():
	rich_text_label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"?", "!", ".", ",":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_letter_display_timer_timeout() -> void:
	_display_letter()
	if dialogue_end == true:
		print("Dialogue ended")
		character.inputs_allowed = true

	pass # Replace with function body.

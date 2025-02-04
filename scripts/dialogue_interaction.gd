extends Area2D
@onready var game_manager: Node = %GameManager
@onready var character: CharacterBody2D = $"../../character"
@onready var dialogue_box_3: MarginContainer = $"../dialogue_box_3"
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

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
		var curr_path = String(get_path())
		print("NODE-> ", get_node("."), "\nPATH-> ", curr_path)
		var curr_dialogue = int(curr_path[curr_path.length() - 1])
		var paths = "../dialogue_interaction" + str(curr_dialogue)
		for i in range(1, curr_dialogue):
			if get_node(paths):
				print("DELETING dialogue->", paths)
				get_node(paths).set_deferred("disabled", true)
		
		#deleting previous dialogue boxes
		
		
		
		#await DialogueManager.start_dialogue(character.position, lines, character)
		#pass
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("char_jump") && area_active:
		dialogue_box_3.start_dialogue(dialogue_id, dialogue_y_offset, dialogue_x_offset)
		if dialogue_box_3.finished:
			#character.inputs_allowed = true
			timer.start(0.25)
			#queue_free()
		
		#Finding the range of dialogues already spoken and deleting previous dialogue interactions
		#this will however always be one dialogue late
		#finds range of dialogue one's or ten's place
		var curr_path = String(get_path())
		var dialogue_range: String
		if int(curr_path[curr_path.length() - 1]) && int(curr_path[curr_path.length() - 2]):
			dialogue_range = curr_path[curr_path.length() - 2]
			dialogue_range += curr_path[curr_path.length() - 1]
		else:
			dialogue_range += curr_path[curr_path.length() - 1]
		
		#print("->", get_path()) #/root/Game/Dialogues/dialogue_interaction1
		#var paths = "../dialogue_interaction" + str(dialogue_range)
		for i in range(1, int(dialogue_range)):
			var paths = "../dialogue_interaction" + str(i)
			if get_node(paths):
				#print("deleting ", get_node(paths))
				get_node(paths).queue_free()
		pass
	pass


func _on_area_exited(area: Area2D) -> void:
	area_active = false
	dialogue_box_3.visible = false
	#queue_free()
	#character.inputs_allowed = true


func _on_timer_timeout() -> void:
	character.inputs_allowed = true
	#print("deleting dialogue box", get_node(get_path()))
	queue_free()
	pass # Replace with function body.

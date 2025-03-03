extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var animation_player: AnimationPlayer = $"Falling rocks/AnimationPlayer"

var game_scene
var level
var level_1 = preload("res://scenes/level1.tscn")
var level_2 = preload("res://scenes/level2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var file_name = "user://Gumm" + str(SaveInfo.slot) + ".save"	
	var savedGame = FileAccess.open(file_name, FileAccess.READ)
	var nodeData 
	
	if savedGame:
		while savedGame.get_position() < savedGame.get_length():
			var jsonString = savedGame.get_line()
			var json = JSON.new()
			json.parse(jsonString)
			nodeData = json.get_data()
			game_scene = level_1 if nodeData["level"] == 1 else level_2
			level = "res://scenes/level1.tscn" if nodeData["level"] == 1 else "res://scenes/level2.tscn"
	else:
		game_scene = level_1
		level = "res://scenes/level1.tscn"
	
	pass # Replace with function body.


func _on_video_stream_player_finished() -> void:
	#video_stream_player.paused = true
	#video_stream_player.autoplay = false
	get_tree().change_scene_to_file(level)
	#animation_player.active = true
	#print("Cutscene finished")
	pass # Replace with function body.

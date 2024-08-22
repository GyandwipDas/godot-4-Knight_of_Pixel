extends Control

@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var animation_player: AnimationPlayer = $"Falling rocks/AnimationPlayer"

var level = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("!")
	pass # Replace with function body.


func _on_video_stream_player_finished() -> void:
	#video_stream_player.paused = true
	#video_stream_player.autoplay = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	#animation_player.active = true
	#print("Cutscene finished")
	pass # Replace with function body.

extends CharacterBody2D

@onready var character: CharacterBody2D = $"../character"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

var hrt_beat_vol = 1
var enable_heartbeat = 0 #0 -> disbled, 1->changing to enabled, 2-> enabled

func distFromChar(from):
		return character.global_position.x - from.global_position.x

func heartbeat_volume(from):
	var visibility = (150 - abs(distFromChar(from))) / 100
	#var visibility = (150 - abs(distFromChar(from)) if 150 > abs(distFromChar(from)) else abs(distFromChar(from)) - 150) / 100

	#if visibility > 0 return visibility else return 0.00
	if visibility >= 0:
		return visibility
	else:
		#timer.start(5)
		#print(audio_stream_player_2d.get("parameters/looping"))
		return 0.00
		
func _process(delta: float) -> void:
	#print(heartbeat_volume(self))
	#print(10*heartbeat_volume(self))
	if enable_heartbeat == 2:
		audio_stream_player_2d.volume_db = 10 * heartbeat_volume(self)
	pass

func hrtbeat_change_to_enabled():
	if enable_heartbeat == 0:
		var tween = create_tween()
		tween.tween_property(audio_stream_player_2d, "volume_db", 15, 2)

	
func heart_beat_tween(from, to):
	var tween = create_tween()
	tween.tween_property(audio_stream_player_2d, "volume_db", from, to)
#
func _on_timer_timeout() -> void:
	#audio_stream_player_2d.set("parameters/looping", 0)
	#print(audio_stream_player_2d.get("parameters/looping"))
	#audio_stream_player_2d.playing
	#queue_free()
	pass # Replace with function body.

extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var rock_types : Array[Rect2i]
@onready var character: CharacterBody2D = $"../../../character"
@onready var killzone_collision: CollisionShape2D = $Killzone/CollisionShape2D
@onready var game_manager: Node = %GameManager
@onready var killzone: Area2D = $Killzone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var r = 0
	var c = 0
	for i in range (1): # rows
		for j in range (4): # columns
			rock_types.append(Rect2i(r,c, 120, 120)) # pixel dimensions
			r += 120
		c += 120
		r = 0
	var rand_index = randi() % rock_types.size()
	#print(rand_index)
	sprite_2d.region_rect = rock_types[rand_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == character.area_2d:
		print(get_path())
		var path = String(get_path())
		game_manager.loadGame()
		print("-->>path ", path, " -->>mem ", game_manager.nodeData["memory"])
		if path[path.length() - 1] == "4" && game_manager.nodeData["memory"] == 0 :
			killzone.monitoring = false
			print("bonk")
	pass # Replace with function body.

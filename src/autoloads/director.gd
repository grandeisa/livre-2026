extends Node

@onready var result_screen: PackedScene = preload("res://scenes/result_screen.tscn")
@onready var test_level: PackedScene = preload("res://scenes/test_level.tscn")
@onready var player_packed: PackedScene = preload("res://scenes/player.tscn")
var accepting_change:bool = true
var _last_devices: Array[int]

func change_to_results_scene(winner_id: int):
	if not accepting_change: return
	accepting_change = false
	var scene = result_screen.instantiate()
	scene.winner_id = winner_id
	get_tree().call_deferred("change_scene_to_node", scene)
	
func change_to_test_level(devices: Array[int] = []) -> void:
	if devices.is_empty():
		devices = _last_devices
	
	var scene = test_level.instantiate()
	get_tree().change_scene_to_node(scene)
	var hud = scene.get_node("HUD")
	
	for i in range(0, len(devices)):
		if devices[i] == -2: continue
		var player: Player = player_packed.instantiate()
		player.id = i
		player.device = devices[i]
		player.position.x += 20 * i
		scene.add_child(player)
		hud._players.append(player)
	
	accepting_change = true

extends Node

const PLAYER_COLOR_AMOUNT: int = 6

@onready var result_screen: PackedScene = preload("res://scenes/result_screen.tscn")
@onready var test_level: PackedScene = preload("res://scenes/test_level.tscn")
@onready var join_screen: PackedScene = preload("res://scenes/join_scene.tscn")
@onready var player_packed: PackedScene = preload("res://scenes/player.tscn")
var accepting_change:bool = true
var _last_devices: Array[int]
var player_colors: Array[Color] = []

func _ready() -> void:
	generate_player_colors()

func change_to_results_scene(winner_id: int, time_offset: float = 1.0):
	if not accepting_change: return
	accepting_change = false
	var scene = result_screen.instantiate()
	scene.winner_id = winner_id
	Engine.time_scale = 0.2
	await get_tree().create_timer(time_offset).timeout
	get_tree().call_deferred("change_scene_to_node", scene)
	Engine.time_scale = 1.0

func change_to_join_screen() -> void:
	var scene = join_screen.instantiate()
	get_tree().change_scene_to_node(scene)
	
func change_to_test_level(devices: Array[int] = []) -> void:
	if devices.is_empty():
		devices = _last_devices
	_last_devices = devices
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

func generate_player_colors() -> void:
	player_colors = []
	for i in range(0, PLAYER_COLOR_AMOUNT):
		var color = Color.RED
		color.h = float(i) / PLAYER_COLOR_AMOUNT
		player_colors.append(color)
	player_colors.shuffle()

## HUD
extends CanvasLayer

@onready var player_hud: PackedScene = preload("res://scenes/player_hud.tscn")

@export var _players: Array[Player]
@export var _huds_container: Container

var player_hud_list: Array = []

func _ready() -> void:
	player_hud_list.resize(5)
	visible = true
	for player: Player in _players:
		var new_hud = player_hud.instantiate()
		
		new_hud.label.text = "Player %d" % (player.id+1)
		new_hud.bar.max_value = Player.MAX_HEALTH_POINTS
		_huds_container.add_child(new_hud)
		player_hud_list[player.id] = new_hud
		await player.ready
		new_hud.label.modulate = Director.player_colors[player.id]
		

func _process(_delta: float) -> void:
	for player: Player in _players:
		player_hud_list[player.id].bar.value = player.health_points

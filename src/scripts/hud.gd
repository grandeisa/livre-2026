## HUD
extends CanvasLayer

@export var _players: Array[Player]
@export var _hp_label: Label

func _ready() -> void:
	visible = true

func _process(_delta: float) -> void:
	var label_str: String = ""
	for player: Player in _players:
		label_str += "Player %d: HP = %d" % [player.id + 1, player.health_points]
		label_str += "; Gauge = %.2f/%.2f" % [player.time_without_atk, Player.MAX_TIME_WITHOUT_ATK]
		label_str += "\n"
	_hp_label.text = label_str

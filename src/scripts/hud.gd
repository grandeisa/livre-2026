## HUD
extends CanvasLayer

@export var _players: Array[Player]
@export var _hp_label: Label

func _ready() -> void:
	visible = true

func _process(_delta: float) -> void:
	var label_str: String = ""
	for player: Player in _players:
		label_str += "Player %d: HP = %d\n" % [player.id + 1, player.health_points]
	_hp_label.text = label_str

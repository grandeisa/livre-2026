## Explosion
extends Area2D

var damage: int = 1
var player_id: int = -1
var duration: float = 1.0

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.id == player_id: return
		body.take_damage(damage)

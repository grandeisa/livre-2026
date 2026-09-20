## Explosion
extends Area2D

var damage: int = 1
var player_id: int = -1
var duration: float = 1.0
var force: float = 250.0

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.id == player_id: return
		if body.invincible: return
		body.take_damage(damage)
		var knockback_direction: Vector2 = body.foot.position - position
		if knockback_direction.is_zero_approx(): knockback_direction = Vector2.UP
		
		body.apply_knockback(knockback_direction.normalized(), force)
		
		

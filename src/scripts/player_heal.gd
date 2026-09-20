extends Area2D

@export var player: Player

var timer: Timer
var lifetime: float = 0.5

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	monitoring = false
	monitorable = false

func activate() -> void:
	visible = true
	monitoring = true
	monitorable = true
	player.can_heal = false
	timer.start(lifetime)
	
func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	if body == player: return
	body.take_heal(player.heal_amount)
	var knockback_direction: Vector2 = global_position - player.global_position
	body.apply_knockback(knockback_direction.normalized(), player.heal_knockback_force)
	
func _on_timer_timeout() -> void:
	monitoring = false
	monitorable = false
	visible = false
	
	await get_tree().create_timer(player.heal_cooldown).timeout
	player.can_heal = true
	

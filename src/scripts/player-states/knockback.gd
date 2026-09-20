## Player Knockback State
extends State

@export var player: Player

var force: float = 200.0
var duration: float = 0.5
var next_state: StringName = 'move'

var direction: Vector2 = Vector2.ONE
var timer: Timer

func _ready() -> void:
	player.got_knockback.connect(_on_knockback)
	
	if not timer:
		timer = Timer.new()
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
	timer.start(duration)

func _enter_state() -> void:
	player.velocity += direction * force

func _on_knockback(k_direction: Vector2, k_force: float) -> void:
	direction = k_direction
	force = k_force

func _on_timer_timeout() -> void:
	player.invincible = false
	start_transition('move')

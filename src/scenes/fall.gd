## Player fall state
extends State

@export var player: Player

func _enter_state() -> void:
	player.current_speed = player.UNGROUNDED_SPEED

func _physics_update_state(delta: float) -> void:
	if player.is_on_floor():
		start_transition("grounded")

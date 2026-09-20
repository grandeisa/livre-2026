## Player fall state
extends State

@export var player: Player

func _enter_state() -> void:
	player.current_speed = player.UNGROUNDED_SPEED

func _physics_update_state(delta: float) -> void:
	if player.is_on_floor():
		start_transition("grounded")
	elif (MultiInput.is_action_just_pressed("p_jump", player.device) and \
		player.time_without_atk >= Player.MIN_TIME_FOR_ATK) \
		or player.time_without_atk > Player.MAX_TIME_WITHOUT_ATK:
		player.time_without_atk = 0.0
		start_transition("jump")

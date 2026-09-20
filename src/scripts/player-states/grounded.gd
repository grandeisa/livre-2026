## Player Grounded State
extends State

@export var player: Player

func _enter_state() -> void:
	player.current_speed = player.GROUNDED_SPEED

func _physics_update_state(_delta: float) -> void:
	if not player.is_on_floor():
		start_transition("fall")
	elif (MultiInput.is_action_just_pressed("p_jump", player.device) and \
		player.time_without_atk >= Player.MIN_TIME_FOR_ATK) \
		or player.time_without_atk > Player.MAX_TIME_WITHOUT_ATK:
		player.time_without_atk = 0.0
		start_transition("jump")
	
func _exit_state() -> void:pass

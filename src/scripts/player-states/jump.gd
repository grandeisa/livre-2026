## Player Jump State
extends State

@export var player: Player

func _enter_state() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.current_speed = player.UNGROUNDED_SPEED
	
func _physics_update_state(delta: float) -> void:
	if MultiInput.is_action_just_released("p_jump", player.device):
		player.velocity.y = max(player.velocity.y, player.JUMP_MIN_VELOCITY_ON_JUMP_EARLY_STOP)
		start_transition("fall")
	
	if player.velocity.y >= 0.0:
		start_transition("fall")

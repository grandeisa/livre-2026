## Player Grounded State
extends State

@export var player: Player

func _enter_state() -> void:
	player.current_speed = player.GROUNDED_SPEED

func _physics_update_state(_delta: float) -> void:
	if not player.is_on_floor():
		start_transition("fall")
	elif MultiInput.is_action_just_pressed("p_jump", player.device):
		start_transition("jump")
	
func _exit_state() -> void:pass

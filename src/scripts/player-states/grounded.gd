## Player Grounded State
extends State

@export var player: Player

func _enter_state() -> void:
	player.current_speed = player.GROUNDED_SPEED

func _process(delta: float) -> void:
	player.time_without_atk += delta

func _physics_update_state(_delta: float) -> void:
	if not player.is_on_floor():
		start_transition("fall")
	elif MultiInput.is_action_just_pressed("p_jump", player.device) \
		or player.time_without_atk > Player.MAX_TIME_WITHOUT_ATK:
		player.time_without_atk = 0.0
		start_transition("jump")
	
func _exit_state() -> void:pass

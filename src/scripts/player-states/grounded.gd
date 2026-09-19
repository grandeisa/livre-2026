extends State

@export var player: Player

func _enter_state() -> void:pass
func _update_state(_delta: float) -> void:pass

func _physics_update_state(_delta: float) -> void:
	if player.input_direction.x:
		player.velocity.x = player.input_direction.x * player.GROUNDED_SPEED
		player.sprite.flip_h = player.input_direction.x < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.GROUNDED_SPEED)
	
func _exit_state() -> void:pass

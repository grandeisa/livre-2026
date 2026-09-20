## Player Jump State
extends State

@export var player: Player

func _enter_state() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.current_speed = player.UNGROUNDED_SPEED
	
	var explosion = Player.explosion_packed.instantiate()
	
	explosion.player_id = player.id
	explosion.damage = player.current_damage
	explosion.global_position = player.foot.global_position
	player.add_sibling(explosion)
	
func _physics_update_state(delta: float) -> void:
	if MultiInput.is_action_just_released("p_jump", player.device):
		player.velocity.y = max(player.velocity.y, player.JUMP_MIN_VELOCITY_ON_JUMP_EARLY_STOP)
	
	if player.velocity.y >= 0.0:
		start_transition("fall")

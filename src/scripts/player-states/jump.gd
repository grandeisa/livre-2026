## Player Jump State
extends State

@export var player: Player

func _ready() -> void:
	player.got_knockback.connect(_on_knockback)
	

func _enter_state() -> void:
	
	var explosion = Player.explosion_packed.instantiate()
	var gauge_fill = min(player.time_without_atk, player.current_max_time) \
		/ player.current_max_time
		
	gauge_fill *= min(player.current_max_time / Player.MAX_TIME_WITHOUT_ATK + 0.25, 1.0)
	
	if gauge_fill == 1.0: gauge_fill += 1.0
	gauge_fill += 0.5
	player.velocity.y = player.JUMP_VELOCITY * (gauge_fill + 0.15)
	
	explosion.player_id = player.id
	explosion.damage = player.current_damage
	explosion.global_position = player.foot.global_position
	
	explosion.scale *= gauge_fill
	explosion.force *= gauge_fill 
	#explosion.get_node("Sprite2D").material = player.sprite.material
	explosion.modulate = Director.player_colors[player.id]
	player.add_sibling(explosion)
	
	player.time_without_atk = 0.0
	if player.can_move:
		player.sprite.play("fall")
	
func _physics_update_state(delta: float) -> void:
	if MultiInput.is_action_just_released("p_jump", player.device):
		player.velocity.y = max(player.velocity.y, player.JUMP_MIN_VELOCITY_ON_JUMP_EARLY_STOP)
		
	player.handle_horizontal_movement(delta)
	
	if player.is_on_floor() or player.velocity.y >= 0.0:
		start_transition("move")
	elif not player.is_on_floor() and player.can_move:
		player.sprite.play("fall")

func _on_knockback(_a,_b) -> void:
	start_transition('knockback')

## Player move State
extends State

@export var player: Player

func _ready() -> void:
	player.got_knockback.connect(_on_knockback)
	
func _physics_update_state(delta: float) -> void:
	if (MultiInput.is_action_just_pressed("p_jump", player.device) and \
		player.time_without_atk >= Player.MIN_TIME_FOR_ATK) \
		or player.time_without_atk > player.current_max_time:
		start_transition("jump")
		
	player.handle_horizontal_movement(delta)
	if player.can_move:
		if not player.is_on_floor():
			player.sprite.play("fall")
		elif player.input_direction.x:
			player.sprite.play("walk")
		else:
			player.sprite.play("idle")
	
func _on_knockback(_a,_b) -> void:
	start_transition('knockback')

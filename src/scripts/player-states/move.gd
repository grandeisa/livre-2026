## Player move State
extends State

@export var player: Player

func _ready() -> void:
	player.got_knockback.connect(_on_knockback)
	

func _enter_state() -> void:
	player.current_acceleration = player.ACCELERATION

func _physics_update_state(delta: float) -> void:
	if (MultiInput.is_action_just_pressed("p_jump", player.device) and \
		player.time_without_atk >= Player.MIN_TIME_FOR_ATK) \
		or player.time_without_atk > Player.MAX_TIME_WITHOUT_ATK:
		start_transition("jump")
		
	player.handle_horizontal_movement(delta)
	
func _on_knockback(_a,_b) -> void:
	start_transition('knockback')

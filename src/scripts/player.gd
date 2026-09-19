class_name Player extends CharacterBody2D


const GROUNDED_SPEED: float = 300.0
const UNGROUNDED_SPEED: float = 175.0
const JUMP_VELOCITY = -300.0
const JUMP_MIN_VELOCITY_ON_JUMP_EARLY_STOP = -50.0
const GRAVITY = Vector2(0, 980.0)

@onready var sprite = $Sprite2D

var input_direction: Vector2 = Vector2.ZERO
var device: int = 0

var current_speed: float = GROUNDED_SPEED
var can_move: bool = true

func _process(_delta: float) -> void:
	input_direction = MultiInput.get_vector("p_left","p_right", "p_up", "p_down", device)

func _physics_process(delta: float) -> void:
	if can_move and input_direction.x:
		velocity.x = input_direction.x * current_speed
		sprite.flip_h = input_direction.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
	if not is_on_floor():
		velocity += GRAVITY * delta
	move_and_slide()

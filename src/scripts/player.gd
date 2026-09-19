class_name Player extends CharacterBody2D


const GROUNDED_SPEED: float = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $Sprite2D

var input_direction: Vector2 = Vector2.ZERO
var input_device: int = 0

func _process(_delta: float) -> void:
	input_direction = MultiInput.get_vector("p_left","p_right", "p_up", "p_down", input_device)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if MultiInput.is_action_just_pressed("p_jump", input_device) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()

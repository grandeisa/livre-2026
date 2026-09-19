class_name Player extends CharacterBody2D


const GROUNDED_SPEED: float = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $Sprite2D

var input_direction: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	input_direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()

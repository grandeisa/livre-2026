class_name Player extends CharacterBody2D


static var explosion_packed: PackedScene = preload("res://scenes/explosion.tscn")

const DESIRED_SPEED: float = 155.0
const ACCELERATION: float = 50.0
const UNGROUNDED_ACCELERATION: float = 30.0
const VELOCITY_STEER_FACTOR: float = 20.0

const JUMP_VELOCITY = -300.0
const JUMP_MIN_VELOCITY_ON_JUMP_EARLY_STOP = -100.0
const GRAVITY = Vector2(0, 980.0)

const MAX_TIME_WITHOUT_ATK: float = 5.0
const MIN_TIME_FOR_ATK: float = 0.5

#region components
@onready var sprite:Sprite2D = $Sprite2D
@export var heal_hitbox: Area2D
@export var attack_hitbox: Area2D
@export var foot: Node2D
#endregion

#region input
var input_direction: Vector2 = Vector2.ZERO
@export var device: int = -1
@export var id: int = 0
#endregion input

var health_points: int = 10
var current_speed: float = DESIRED_SPEED
var current_acceleration: float = ACCELERATION
var current_gravity: Vector2 = GRAVITY
var current_damage: int = 3
var can_move: bool = true
var can_heal: bool = true
var can_attack: bool = true
var time_without_atk = 0.0
var invincible: bool = false

signal got_knockback(direction: Vector2, force: float)

func _process(delta: float) -> void:
	input_direction = MultiInput.get_vector("p_left","p_right", "p_up", "p_down", device)
	time_without_atk += delta

func _physics_process(delta: float) -> void:
	if input_direction.x:
		sprite.flip_h = input_direction.x < 0
		heal_hitbox.position.x = abs(heal_hitbox.position.x) * (1 if input_direction.x > 0 else -1)
		
	if not is_on_floor():
		velocity += current_gravity * delta
	move_and_slide()
	
	if can_heal and MultiInput.is_action_just_pressed("p_heal", device):
		can_heal = false
		heal_hitbox.visible = true
		for player in heal_hitbox.get_overlapping_bodies():
			if player is not Player: continue
			if player == self: continue
			player.health_points += 2
		
		await get_tree().create_timer(5.0).timeout
		can_heal = true
		heal_hitbox.visible = false

func handle_horizontal_movement(delta: float) -> void:
	var will_move: bool = input_direction.x != 0
	var desired_velocity: float = input_direction.x * current_speed
	
	if abs(velocity.x) < current_speed and will_move:
		velocity.x = lerp(velocity.x, desired_velocity, ACCELERATION * delta)
	else:
		velocity.x = lerp(velocity.x, desired_velocity, VELOCITY_STEER_FACTOR * delta)


func take_damage(amount: int) -> void:
	health_points -= amount
	if health_points <= 0: Director.change_to_results_scene(id)

func take_heal(amount: int) -> void:
	health_points += amount
	
func apply_knockback(direction: Vector2, force: float) -> void:
	got_knockback.emit(direction, force)

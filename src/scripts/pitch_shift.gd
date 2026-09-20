extends AudioStreamPlayer

@export var min_pitch_scale: float = 0.9
@export var max_pitch_scale: float = 1.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pitch_scale = randf_range(min_pitch_scale, max_pitch_scale)

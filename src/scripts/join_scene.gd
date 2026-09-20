extends Control

@onready var grid = $GridContainer

var join_containers: Array = []
var device_list: Array[int] = []
var device_available: Array[bool] = [true, true, true, true]

func _ready() -> void:
	Director.generate_player_colors()
	device_list.resize(4)
	device_list.fill(-2)
	
	join_containers = grid.get_children()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_C:
			assign_id(-1)
	elif event is InputEventJoypadButton:
		if not event.pressed: return
		
		if abs(event.button_index) == JOY_BUTTON_A:
			print(event.device)
			assign_id(event.device)
	
func assign_id(device: int) -> void:
	if true not in device_available: return
	if device in device_list: return
	var id: int = device_available.find(true)
	device_available[id] = false
	device_list[id] = device
	
	join_containers[id].get_node("Label").text = "Player %d READY" % (id+1)
	join_containers[id].modulate = Director.player_colors[id]
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p_reset@all") and device_available.count(false) >= 2:
		Director.change_to_test_level(device_list)

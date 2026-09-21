extends Control

const EMPTY_DEVICE: int = -100

@onready var grid = $GridContainer
@export_multiline var no_join_text: String = "INSERT JOIN TEXT"


var join_containers: Array = []
var device_list: Array[int] = []
var device_available: Array[bool] = [true, true, true, true]

func _ready() -> void:
	Director.generate_player_colors()
	device_list.resize(4)
	device_list.fill(EMPTY_DEVICE)
	
	join_containers = grid.get_children()
	for container in join_containers:
		container.get_node("Label").text = no_join_text
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p_reset@all") and device_available.count(false) >= 2:
		Director.change_to_test_level(device_list)
		return
	
	for device in _get_device_press("p_jump"):
		assign_id(device)
	for device in _get_device_press("p_heal"):
		unassign_id(device)

## Returns a list of devices that have just pressed the action.
## [param kb_amount] is the amount of keyboard devices to be checked
## [param joy_amount] is the amount of joystick devices to be checked
func _get_device_press(action: StringName, kb_amount: int = 2, joy_amount: int = 8) -> Array[int]:
	var presses: Array[int] = []
	for id in range(-kb_amount, joy_amount):
		if MultiInput.is_action_just_pressed(action, id):
			presses.append(id)
	return presses

func assign_id(device: int) -> void:
	if true not in device_available: return
	if device in device_list: return
	var id: int = device_available.find(true)
	device_available[id] = false
	device_list[id] = device
	
	var device_name = MultiInput.get_device_name(device)
	
	join_containers[id].get_node("Label").text = "Player %d READY\n%s" % \
					[(id+1), device_name]
	
	join_containers[id].modulate = Director.player_colors[id]
	
func unassign_id(device: int) -> void:
	if false not in device_available: return
	if device not in device_list: return
	var id: int = device_list.find(device)
	device_available[id] = true
	device_list[id] = EMPTY_DEVICE
	
	join_containers[id].get_node("Label").text = no_join_text
	join_containers[id].modulate = Color.WHITE

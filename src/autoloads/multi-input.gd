## MultiInput autoload
## 
## Used to provide simple access to multi device input
extends Node

# Reserve all negative values to keyboard
const KEYBOARD_1: int = -1
const KEYBOARD_2: int = -2
const MAX_CONTROLLERS_ADDED: int = 8

func _get_kb_action_name(action: StringName, device: int) -> String:
	return action + "@kb-" + str(abs(device)) 
	
func _get_joy_action_name(action: StringName, device: int) -> String:
	return action + "@joy-" + str(device)

func _is_device_controller(device: int) -> bool:
	return device >= 0

func is_action_just_pressed(action: StringName, device: int = KEYBOARD_1) -> bool:
		if not _is_device_controller(device): # KEYBOARD
			action = _get_kb_action_name(action, device)
		else: action = _get_joy_action_name(action, device)
		return Input.is_action_just_pressed(action)
		
		
func is_action_just_released(action: StringName, device: int = KEYBOARD_1) -> bool:
		if not _is_device_controller(device): # KEYBOARD
			action = _get_kb_action_name(action, device)
		else: action = _get_joy_action_name(action, device)
		return Input.is_action_just_released(action)
	
func is_action_pressed(action: StringName, device: int = KEYBOARD_1) -> bool:
		if not _is_device_controller(device): # KEYBOARD
			action = _get_kb_action_name(action, device)
		else: action = _get_joy_action_name(action, device)
		return Input.is_action_pressed(action)
		
		
func get_axis(negative: StringName, positive: StringName, device: int = KEYBOARD_1) -> float:
	if not _is_device_controller(device): # KEYBOARD
		negative = _get_kb_action_name(negative, device)
		positive = _get_kb_action_name(positive, device)
	else:
		negative = _get_joy_action_name(negative, device)
		positive = _get_joy_action_name(positive, device)
	return Input.get_axis(negative, positive)
		
func get_vector(negative_x: StringName, positive_x: StringName,\
 negative_y: StringName, positive_y: StringName, device: int = KEYBOARD_1) -> Vector2:
	if not _is_device_controller(device): # KEYBOARD
		negative_x = _get_kb_action_name(negative_x, device)
		positive_x = _get_kb_action_name(positive_x, device)
		negative_y = _get_kb_action_name(negative_y, device)
		positive_y = _get_kb_action_name(positive_y, device)
	else:
		negative_x = _get_joy_action_name(negative_x, device)
		positive_x = _get_joy_action_name(positive_x, device)
		negative_y = _get_joy_action_name(negative_y, device)
		positive_y = _get_joy_action_name(positive_y, device)
	return Input.get_vector(negative_x, positive_x, negative_y, positive_y)

#####

func _ready() -> void:
	_add_joy_actions()

## Adds all controller inputs as separate actions based on the @joy-all actions
func _add_joy_actions() -> void:
	var all_actions: Array[StringName] = InputMap.get_actions()
	for action:StringName in all_actions:
		if not action.ends_with("@joy-all"): continue
		for i:int in range(0, MAX_CONTROLLERS_ADDED):
			var new_action: String = action.split("@")[0] + "@joy-" + str(i)
			InputMap.add_action(new_action)
			var events: Array[InputEvent] = InputMap.action_get_events(action)
			for event: InputEvent in events:
				var copied_event: InputEvent = event.duplicate_deep()
				copied_event.device = i
				InputMap.action_add_event(new_action, copied_event)

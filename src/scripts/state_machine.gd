class_name StateMachine extends Node

@export var _current_state: State

var _states: Dictionary[String, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.transition.connect(_on_signal_transition)
			
	_current_state._enter_state()

func _process(delta: float) -> void:
	_current_state._update_state(delta)

func _physics_process(delta: float) -> void:
	_current_state._physics_update_state(delta)

func _on_signal_transition(source: State, next: String) -> void:
	if _current_state != source or next not in _states: return
	next = next.to_lower()
	source._exit_state()
	_current_state = _states[next]
	_current_state._enter_state()
	

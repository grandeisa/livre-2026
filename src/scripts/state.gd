@abstract
class_name State extends Node

signal transition(source: State, next: String)

func _enter_state() -> void: pass
func _update_state(delta: float) -> void: pass
func _physics_update_state(delta: float) -> void: pass
func _exit_state() -> void: pass

func start_transition(next: String) -> void:
	transition.emit(self, next)

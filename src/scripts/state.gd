@abstract
class_name State extends Node

signal transition(source: State, next: String)

@abstract func _enter_state() -> void
@abstract func _update_state(delta: float) -> void
@abstract func _physics_update_state(delta: float) -> void
@abstract func _exit_state() -> void

func start_transition(next: String) -> void:
	transition.emit(self, next)

extends Node

@onready var result_screen: PackedScene = preload("res://scenes/result_screen.tscn")
@onready var test_level: PackedScene = preload("res://scenes/test_level.tscn")

func change_to_results_scene(winner_id: int):
	var scene = result_screen.instantiate()
	scene.winner_id = winner_id
	get_tree().change_scene_to_node(scene)
	
func change_to_test_level() -> void:
	var scene = test_level.instantiate()
	get_tree().change_scene_to_node(scene)

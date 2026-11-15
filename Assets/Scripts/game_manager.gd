extends Node

var starting_area = 1
var area_container : Node2D
var player : PlayerController

func _ready() -> void:
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	#reset_energy_cells()

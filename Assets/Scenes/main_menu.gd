extends Control

#preloads level scene
var level_scene = preload("res://Assets/Scenes/Areas/area_1.tscn")

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_1.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()

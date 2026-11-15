extends Control

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")


func _on_controls_pressed() -> void:
	pass 

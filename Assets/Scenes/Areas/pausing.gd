extends Node2D

@onready var pause_menu = $PauseMenu

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):  # makes esc key bind to pause menu
		pause_menu.visible = not pause_menu.visible
		get_tree().paused = pause_menu.visible

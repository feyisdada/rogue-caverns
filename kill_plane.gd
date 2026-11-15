extends Area2D

@export var offset := -600  # how far below camera

func _process(_delta):
	var cam = get_viewport().get_camera_2d()
	if cam:
		global_position.y = cam.global_position.y + offset

func _on_body_entered(body):
	if body.has_method("die"):
		body.die()

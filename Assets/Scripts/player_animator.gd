extends Node2D 

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(delta: float) -> void:
	if player_controller.direction == 1:
		sprite.flip_h = false #if player is moving to the right don't flip character horizontally
	elif player_controller.direction == -1:
		sprite.flip_h = true #if player is moving left, flip character horizontally
		
	if abs(player_controller.velocity.x) > 0.0: #use of absolute value to determine if movement to play animation
		animation_player.play("move")
	else:
		animation_player.play("idle") #no movement so play idle animation

#plays jump animation
	if player_controller.velocity.y < 0.0: #no use of abs() due to different animations for different directions
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")

extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"): # only reacts to Player
		queue_free() # removes the coin
		Global.score += 1 #adds 1 to score
		queue_free()

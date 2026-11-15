extends Label
func _process(_delta):
	text = "Best: " + str(Global.best_height) + "m"

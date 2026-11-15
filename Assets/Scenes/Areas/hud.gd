extends CanvasLayer

@onready var coins_label = $CoinsLabel #link variable to the ScoreLabel node when scene starts

func _process(delta):
	coins_label.text = "Coins: " + str(Global.score) #update label text to show current score

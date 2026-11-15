extends Node

var score := 0
var height := 0
var best_height := 0

const SAVE_FILE = "user:// savegame.save"

func reset():
	score = 0
	height = 0

func save_game():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	var data = {
		"best_height": best_height
	}
	file.store_string(JSON.stringify(data))

func load_game():
	if FileAccess.file_exists(SAVE_FILE):
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		
		if data:
			best_height = data["best_height"]

func _ready():
	load_game()

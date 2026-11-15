extends Node2D

@export var player: Node2D
@export var platform_tile_scene: PackedScene
@export var left_bound: float = -180
@export var right_bound: float = 180
@export var rows_ahead := 6
@export var cleanup_distance := 200
@export var coin_scene: PackedScene
@export var coin_spawn_chance := 0.15 # 15% chance for a coin to appear per tile


# Platform settings
const TILE_SIZE = 16
const MIN_PLATFORM_LENGTH = 3
const MAX_PLATFORM_LENGTH = 5
const BASE_VERTICAL_GAP = 40 
const MAX_HORIZONTAL_GAP = 4 * TILE_SIZE
const MIN_HORIZONTAL_SHIFT = 2 * TILE_SIZE
const DIFFICULTY_STEP = 300.0
const MAX_EDGE_GAP = 48  # max horizontal jump the player can make between platforms


# variables for tracking platform positions
var last_platform_center_x: float
var last_platform_width: float
var next_row_y: float

func _ready():
	randomize()

	if player == null:
		push_error("Player not assigned")
		return

	#create starting floor
	var floor_y = player.position.y + 32
	var floor_length = 8
	var floor_width = floor_length * TILE_SIZE

	spawn_platform(Vector2(player.position.x - floor_width / 2, floor_y), floor_length)

	# place player on starting floor
	player.position.y = floor_y - TILE_SIZE
	player.set_physics_process(true)

	#stores position of first platform so new ones can connect to it
	last_platform_center_x = player.position.x
	last_platform_width = floor_width
	next_row_y = floor_y - BASE_VERTICAL_GAP

	# spawn initial rows above player
	for i in range(rows_ahead):
		spawn_platform_row(next_row_y)
		next_row_y -= BASE_VERTICAL_GAP


func _process(delta):
	var camera_y = player.position.y

	# generate new platform rows above player as player progresses higher
	while next_row_y > camera_y - rows_ahead * BASE_VERTICAL_GAP:
		spawn_platform_row(next_row_y)
		next_row_y -= BASE_VERTICAL_GAP

	#remove platforms that are far below the player
	cleanup_old_platforms()


#create a row of platforms
func spawn_platform_row(y: float):
	var length = randi_range(MIN_PLATFORM_LENGTH, MAX_PLATFORM_LENGTH)
	var width = length * TILE_SIZE

	var prev_left = last_platform_center_x - last_platform_width / 2
	var prev_right = last_platform_center_x + last_platform_width / 2

	var attempts := 0
	var spawn_x := 0.0
	var valid := false

	#try random positions until a jumpable platform is found
	while attempts < 10 and not valid:
		# random left edge
		spawn_x = randf_range(
			left_bound,
			right_bound - width
		)
		
		var new_left = spawn_x
		var new_right = spawn_x + width

		# Calculate horizontal distance between new platform and previous
		var gap_left = abs(new_left - prev_right)
		var gap_right = abs(prev_left - new_right)

		#if jump distance is small enought the platform is valid
		if min(gap_left, gap_right) <= MAX_EDGE_GAP:
			valid = true

		attempts += 1

	#if no valid position found, place a platform close to previous one
	if not valid:
		spawn_x = clamp(
			prev_right + TILE_SIZE,
			left_bound,
			right_bound - width
		)

	spawn_platform(Vector2(spawn_x, y), length)

	# Update the stored platform position for the next row
	last_platform_center_x = spawn_x + width / 2
	last_platform_width = width

#Spawn platform tiles
func spawn_platform(start_position: Vector2, length: int):
	for i in range(length):
		var tile = platform_tile_scene.instantiate()
		add_child(tile)
		tile.position = Vector2(
			start_position.x + i * TILE_SIZE,
			start_position.y
		)
	#random coin spawn
		if randf() < coin_spawn_chance:
			var coin = coin_scene.instantiate()
			add_child(coin)

			# center coin and place slightly above tile
			coin.position = tile.position + Vector2(TILE_SIZE / 2, -TILE_SIZE)


#Remove old platforms
func cleanup_old_platforms():
	#Deletes platforms that are far below player
	for child in get_children():
		if child is Node2D and child.position.y > player.position.y + cleanup_distance:
			child.queue_free()


#Difficulty calculation
func get_difficulty() -> float:
	#difficulty increases based on height climbed
	var climbed = max(0.0, -player.position.y)
	return clamp(climbed / DIFFICULTY_STEP, 0.0, 5.0)

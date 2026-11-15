extends CharacterBody2D #player controls
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var fall_limit := 300  # how far below highest point before death

var new_record_triggered := false
@onready var new_record_label = get_tree().get_first_node_in_group("new_record_label")
@onready var dying_label = get_tree().get_first_node_in_group("dying_label")

var speed_multiplier = 30.0
var jump_multiplier = 30.0
var direction = 0
var max_height: float = 0.0


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
func _ready():
	add_to_group("player")
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_power * jump_multiplier

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	if -global_position.y > max_height:
		max_height = -global_position.y
		Global.height = int(max_height / 10)

		if Global.height > Global.best_height:
			Global.best_height = Global.height
			Global.save_game()
			
			if not new_record_triggered:
				new_record_triggered = true
				show_new_record()

	if -global_position.y < max_height - fall_limit:	# Kill if fallen too far below highest point
			die()
	move_and_slide()



func die():
	Global.reset()
	get_tree().reload_current_scene()
	dying_label.visible = true

func show_new_record():
	if new_record_label:
		new_record_label.visible = true

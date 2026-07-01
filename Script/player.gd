extends CharacterBody3D

const SPEED = 5.0

const MOUSE_SENSITIVITY = 0.003

@onready var head = $Head
@onready var camera = $Head/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)

		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

func _physics_process(_delta):
	var input := Vector2.ZERO

	if Input.is_action_pressed("move_forward"):
		input.y -= 1

	if Input.is_action_pressed("move_backward"):
		input.y += 1

	if Input.is_action_pressed("move_left"):
		input.x -= 1

	if Input.is_action_pressed("move_right"):
		input.x += 1

	input = input.normalized()

	velocity.x = input.x * SPEED
	velocity.z = input.y * SPEED

	move_and_slide()

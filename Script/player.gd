extends CharacterBody3D

@export var walk_speed := 5.0
@export var sprint_speed := 9.0
@export var speed_multiplier := 1.0

const MOUSE_SENSITIVITY = 0.003

@onready var head = $Head
@onready var camera = $Head/Camera3D

const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)

		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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

	var direction = (transform.basis * Vector3(input.x, 0, input.y)).normalized()

	var speed = walk_speed

	if Input.is_action_pressed("sprint"):
		speed = sprint_speed

	speed *= speed_multiplier

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()

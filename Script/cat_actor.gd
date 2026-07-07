extends Node3D

@export var speed := 2.5
@export var can_move := false

@export var start_point: Marker3D
@export var middle_point: Marker3D
@export var end_point: Marker3D

@export var player: CharacterBody3D

@onready var model = $Model
@onready var meow = $CatMeow

enum CatState {
	WAITING,
	GO_TO_MIDDLE,
	LOOK_AT_PLAYER,
	GO_TO_END,
	FINISHED
}

var state = CatState.WAITING
var target: Marker3D
var state_timer := 0.0

var has_meowed := false

func _process(delta):
	match state:
		CatState.WAITING:
			pass

		CatState.GO_TO_MIDDLE:
			var direction = (target.global_position - global_position).normalized()
			global_position += direction * speed * delta

			if global_position.distance_to(target.global_position) < 0.1:
				global_position = target.global_position
				state = CatState.LOOK_AT_PLAYER
				state_timer = 0.5

		CatState.LOOK_AT_PLAYER:
			state_timer -= delta

			if state_timer <= 0:
				model.rotation.y = deg_to_rad(-35)

				# Stay in this state for now.
				# We'll continue from here in the next step.

		CatState.GO_TO_END:
			pass

		CatState.FINISHED:
			pass


func play_meow():
	if has_meowed:
		return

	has_meowed = true
	meow.play()


func look_at_player():
	model.rotation.y = deg_to_rad(-35)


func start_crossing():
	target = middle_point
	state = CatState.GO_TO_MIDDLE

extends Node3D

@export var speed := 2.5
@export var can_move := false

@export var start_point: Marker3D
@export var middle_point: Marker3D
@export var end_point: Marker3D

@onready var model = $Model
@onready var meow = $CatMeow

var has_meowed := false

func _process(delta):
	if !can_move:
		return
		
	position.x += speed * delta
	
	if position.x > 6:
		queue_free()
		
func play_meow():
	if has_meowed:
		return
		
	has_meowed = true
	meow.play()

func look_at_player():
	model.rotation.y = deg_to_rad(-35)

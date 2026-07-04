extends CharacterBody3D

@export var speed := 4.0

func _physics_process(_delta):
	print("Cat Running")
	velocity.x = speed
	move_and_slide()

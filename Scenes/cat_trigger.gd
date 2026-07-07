extends Area3D

@onready var cat = $"../../Props/CatActor"
@onready var player = $"../../Player"

func _on_body_entered(body):
	if body.name != "Player":
		return

	monitoring = false

	player.speed_multiplier = 0.4

	cat.play_meow()

	#await get_tree().create_timer(0.5).timeout

	#cat.look_at_player()

	await get_tree().create_timer(0.8).timeout

	cat.start_crossing()

	await get_tree().create_timer(2.0).timeout

	player.speed_multiplier = 1.0

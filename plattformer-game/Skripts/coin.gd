extends Area2D


@onready var game_manager: Node = %GameManeger
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound: AudioStreamPlayer2D = $pickup


var collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return

	
	if body.name != "Player":
		return

	collected = true

	
	monitoring = false

	
	game_manager.add_point(1)

	
	pickup_sound.play()

	
	animation_player.play("Pickup")

	
	await animation_player.animation_finished

	
	if pickup_sound.playing:
		await pickup_sound.finished

	
	queue_free()

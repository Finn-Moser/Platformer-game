extends Area2D

@onready var game_manager: Node = %GameManeger
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var collected := false

func _on_body_entered():
	if collected:
		return
	collected = true

	# Minuspunkt
	game_manager.remove_point()

	# Death-Animation abspielen
	sprite.play("death")

	# Nach 0.7 Sekunden löschen
	await get_tree().create_timer(0.5).timeout

	queue_free()

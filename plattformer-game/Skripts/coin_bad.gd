extends Area2D

@onready var game_manager: Node = %GameManeger
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return

	collected = true

	
	game_manager.remove_point()

	
	sprite.play("death")

	
	animation_player.play("death")

	
	await get_tree().create_timer(0.5).timeout

	
	queue_free()

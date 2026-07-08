extends Area2D

@onready var game_manager: Node = %GameManeger
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	animation_player.play("Pickup")
	game_manager.add_point()

extends Area2D

@onready var game_manager: Node = %GameManeger
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
		game_manager.add_health()
		animation_player.play("Hearts")

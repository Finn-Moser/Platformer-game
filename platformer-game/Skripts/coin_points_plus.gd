extends Area2D

@onready var game_maneger: Node = %GameManeger

func _on_body_entered(_body: Node2D) -> void:
	queue_free()
	game_maneger.add_point(5)

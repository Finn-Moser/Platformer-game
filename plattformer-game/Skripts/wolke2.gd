extends Area2D

@export var bounce_force := 600

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("bounce_from_cloud"):
		body.bounce_from_cloud(bounce_force)

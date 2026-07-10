extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var current = get_tree().current_scene.name
		
		if current == "Level 1":
			get_tree().change_scene_to_file("res://scenes/Level 2.tscn")
		elif current == "Level 2":
			get_tree().change_scene_to_file("res://scenes/Level 3.tscn")
		elif current == "Level 3":
			get_tree().change_scene_to_file("res://scenes/Level 4	.tscn")

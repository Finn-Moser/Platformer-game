extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 2.tscn")


func _on_button_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 1.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level 3.tscn")


func _on_button_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")

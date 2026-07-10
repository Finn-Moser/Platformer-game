extends Node

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Level 1.tscn")
	print ("button 1 presst")
func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Level 2.tscn")
	print ("button 2 presst")
func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Level 3.tscn")
	print ("button 3 presst")

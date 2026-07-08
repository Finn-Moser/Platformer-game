extends Node
@onready var menu: Button = $Pausepanel/VBoxContainer/Menu
@onready var resume: Button = $Pausepanel/VBoxContainer/Resume
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Pausepanel.visible = false


func show_pause_menu():
	$Pausepanel.visible = true
	get_tree().paused = true


func hide_pause_menu():
	$Pausepanel.visible = false
	get_tree().paused = false


func toggle_pause():
	if $Pausepanel.visible:
		hide_pause_menu()
	else:
		show_pause_menu()


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()


func _on_resume_pressed() -> void:
	# Spiel fortsetzen
	hide_pause_menu()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

extends Node

@export var hearts: Array[TextureRect]        
@onready var label: Label = %Label           
@onready var coin_points_plus: Area2D = $"../Coin points plus"





var lives: int = 3
var points: int = 0
var max_health: int = 3
var checkpoint_position: Vector2 = Vector2.ZERO
var has_checkpoint: bool = false



#  checkpoint
func set_checkpoint(pos: Vector2) -> void:
	checkpoint_position = pos
	has_checkpoint = true
	print("Checkpoint saved:", pos)

var player: Node2D

func register_player(p):
	player = p

func decrease_health():
	if lives <= 0:
		return

	lives -= 1
	print("Lives left:", lives)

	if lives >= 0 and lives < hearts.size():
		hearts[lives].visible = false

	if lives == 0:
		get_tree().reload_current_scene()



func add_health(amount: int = 1) -> void:
	lives = min(lives + amount, max_health)
	print("Lives:", lives)
	_update_hearts()



func _update_hearts() -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < lives


func add_point(amount: int = 1):
	points += amount
	update_label()


func remove_point(amount: int = 1):
	points -= amount
	update_label()



func update_label():
	label.text = str(points)

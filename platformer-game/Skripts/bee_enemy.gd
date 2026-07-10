extends Node2D

var t: float = 0.0
var start_y: float
var offset: float
var moving: bool = false

func _ready() -> void:
	start_y = position.y
	offset = randf() * TAU

func _on_body_dectector_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return  # Nur der Spieler darf Bewegung starten

	print("Body Detector ausgelöst von:", body.name)
	moving = true

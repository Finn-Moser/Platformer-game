extends Area2D

@onready var game_manager: Node = %GameManeger

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":
		print("Player hit spikes!")
		
		# Leben abziehen
		if game_manager.has_method("decrease_health"):
			game_manager.decrease_health()

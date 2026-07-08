extends CollisionShape2D
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	var y_delta = position.y - body.position.y

	if y_delta > 20:
		print("Enemy defeated!")
		queue_free()  
		if body.has_method("jump"):
			body.jump()  
	else:
		print("Player hit from side → die")
		if body.has_method("die"):
			body.die()

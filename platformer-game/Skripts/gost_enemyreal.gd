extends CharacterBody2D

@export var speed: float = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var game_manager: Node = %GameManeger

var dead: bool = false

func _physics_process(_delta: float) -> void:
	if dead:
		return

	velocity.x = speed
	move_and_slide()

func _on_wall_detector_body_entered(_body: Node2D) -> void:
	speed = -speed
	animated_sprite_2d.flip_h = speed < 0

func _on_player_detector_body_entered(body: Node2D) -> void:
	if dead:
		return

	if body.name == "Player":
		var player = body as CharacterBody2D

		var player_above = player.global_position.y < global_position.y - 5
		var falling = player.velocity.y > 0

		if player_above and falling:
			player.velocity.y = -200
			die()
		else:
			game_manager.decrease_health()

# Gegner stirbt
func die() -> void:
	if dead:
		return

	dead = true
	speed = 0
	collision_shape_2d.disabled = true

	if animated_sprite_2d.sprite_frames.has_animation("death"):
		animated_sprite_2d.play("death")

	await get_tree().create_timer(0.6).timeout
	queue_free()

extends CharacterBody2D

const SPEED := 140.0
const JUMP_VELOCITY := -250.0
const GRAVITY := 900.0
const MAX_JUMPS := 20


@onready var sprite_2d = $AnimatedSprite2D
@export var particle: PackedScene
@onready var run_particle: PackedScene

var jump_count := 0
var is_dead := false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Schwerkraft
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jump_count = 0

	# Bewegung
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	# Springen (Doppelsprung)
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

		if jump_count == 1:
			sprite_2d.play("jumping")
		elif jump_count == 2:
			sprite_2d.play("double jump")
			spawn_particle()

	move_and_slide()

	# Spiegelung
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0

	# Animationen am Boden
	if is_on_floor():
		if abs(velocity.x) > 1:
			sprite_2d.play("flying")
		else:
			sprite_2d.play("defult")

# Partikel für Doppelsprung
func spawn_particle() -> void:
	if particle == null:
		return

	var p = particle.instantiate()
	p.position = position + Vector2(0, 10)
	get_parent().add_child(p)

	await get_tree().create_timer(0.4).timeout
	if is_instance_valid(p):
		p.queue_free()

# Spieler stirbt
func die() -> void:
	if is_dead:
		return

	is_dead = true
	sprite_2d.play("death")
	set_physics_process(false)

	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()


func _on_resume_pressed() -> void:
	pass # Replace with function body.

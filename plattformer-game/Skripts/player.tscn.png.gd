extends CharacterBody2D

const SPEED := 140.0
const JUMP_VELOCITY := -250.0
const GRAVITY := 900.0

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var particle: PackedScene


@onready var col_normal = $CollisionNormal
@onready var col_flying = $CollisionFlying

var jump_count := 0
var is_dead := false
var is_level3 := false
var max_jumps := 2

func _ready() -> void:
	is_level3 = get_tree().current_scene.scene_file_path == "res://scenes/Level 3.tscn"

	if is_level3:
		max_jumps = 3
		col_normal.disabled = true
		col_flying.disabled = false
	else:
		max_jumps = 2
		col_normal.disabled = false
		col_flying.disabled = true


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	
	if not is_on_floor():
		if is_level3:
			if velocity.y > 0:
				velocity.y += (GRAVITY * 0.6) * delta   
			else:
				velocity.y += GRAVITY * delta           
		else:
			velocity.y += GRAVITY * delta
	else:
		jump_count = 0

	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	move_and_slide()

	
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0

	_play_animation()


func _play_animation() -> void:

	# LEVEL 3 
	if is_level3:

		if is_on_floor():
			if abs(velocity.x) > 1:
				sprite_2d.play("flying")
			else:
				sprite_2d.play("default")
		else:
			# In der Luft in Level 3 → immer flying
			sprite_2d.play("flying")

		return


	#  NORMALE LEVEL
	if is_on_floor():
		if abs(velocity.x) > 1:
			sprite_2d.play("running")
		else:
			sprite_2d.play("defult")
		return

	
	if velocity.y > 0:
		sprite_2d.play("fall")
		return

	if jump_count == 1:
		sprite_2d.play("jumping")
	else:
		sprite_2d.play("double jump")

func die() -> void:
	if is_dead:
		return

	is_dead = true
	sprite_2d.play("death")
	set_physics_process(false)

	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()

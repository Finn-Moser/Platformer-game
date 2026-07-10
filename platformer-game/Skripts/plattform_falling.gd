extends AnimatableBody2D

@export var delay_before_fall := 0.4
@export var fall_speed := 500.0
@export var fall_accel := 1400.0
@export var destroy_after := 3.0

var falling := false
var velocity := 0.0
var timer := 0.0

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	# Wackeln starten
	$AnimationPlayer.play("shake")
	start_fall_after_delay()


func start_fall_after_delay() -> void:
	await get_tree().create_timer(delay_before_fall).timeout
	falling = true
	collision_layer = 0
	collision_mask = 0


func _physics_process(delta):
	if not falling:
		return

	velocity += fall_accel * delta
	global_position.y += velocity * delta

	timer += delta
	if timer > destroy_after:
		queue_free()

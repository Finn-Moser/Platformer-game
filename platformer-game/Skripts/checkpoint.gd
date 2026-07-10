extends Area2D

signal activated(position)

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var col: CollisionShape2D = $CollisionShape2D

var is_active := false


func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

	col.disabled = false

	if anim.sprite_frames.has_animation("idle"):
		anim.play("idle")


func _on_body_entered(body):
	if is_active:
		return
	
	if body.is_in_group("player"):
		_activate_checkpoint()
		emit_signal("activated", global_position)


func _activate_checkpoint():
	is_active = true

	if anim.sprite_frames.has_animation("activate"):
		anim.play("activate")
	elif anim.sprite_frames.has_animation("active"):
		anim.play("active")

	modulate = Color(0.3, 1.0, 0.3)
	col.disabled = true

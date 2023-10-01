class_name Sanity
extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# position & movement
	var x = get_viewport_rect().size.x + 50
	var y = randf_range(50,get_viewport_rect().size.y - 50)
	position = Vector2(x, y)
	var speed = -get_viewport_rect().size.x / 10
	constant_torque = 25
	apply_central_impulse(Vector2(speed, 0))

func _on_body_entered(body: Node2D):
	print('_on_body_entered')
	if (body is Player):
		body.change_health(+1)
		$EOLParticles.emitting = true
		$EOLParticles.reparent(get_parent())
		$EOLAudio.play(0)
		$EOLAudio.reparent(get_parent())
		queue_free()

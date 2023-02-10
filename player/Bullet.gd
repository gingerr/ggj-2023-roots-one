class_name Bullet 
extends Area2D

var velocity = Vector2(1000, 0)

func _ready():
	$ShootSound.play(0.1)

func _physics_process(delta):
	position += velocity * delta

func _process(delta):
	if is_outside_view_bounds():
		queue_free()
	position += velocity * delta
	rotation = velocity.angle()

func is_outside_view_bounds():
	return position.x>DisplayServer.screen_get_size().x or position.x<0.0\
		or position.y>DisplayServer.screen_get_size().y or position.y<0.0

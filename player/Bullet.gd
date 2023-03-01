class_name Bullet 
extends Area2D

var velocity = Vector2(1000, 0)

func _physics_process(delta):
	position += velocity * delta

func _process(delta):
	if is_outside_view_bounds():
		queue_free()
	position += velocity * delta
	rotation = velocity.angle()

func is_outside_view_bounds():
	var viewportSize: Vector2 = get_viewport_rect().size
	return position.x>viewportSize.x or position.x<0.0\
		or position.y>viewportSize.y or position.y<0.0

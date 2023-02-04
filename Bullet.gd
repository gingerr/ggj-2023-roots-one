class_name Bullet 
extends Area2D

var velocity = Vector2(1000, 0)

func _ready():
	#position.x = 100
#	position.y = get_viewport_rect().size.y / 2
	scale.x = 0.05
	scale.y = 0.05

func _physics_process(delta):
	position += velocity * delta

func _process(delta):
	if is_outside_view_bounds():
		print("bullet outside screen")
		queue_free()
	position += velocity * delta
	rotation = velocity.angle()

func is_outside_view_bounds():
	return position.x>OS.get_screen_size().x or position.x<0.0\
		or position.y>OS.get_screen_size().y or position.y<0.0

func _on_BallisticBullet_body_entered(body):
	print("bullet hit something")
	if body != get_node(""):
		queue_free()

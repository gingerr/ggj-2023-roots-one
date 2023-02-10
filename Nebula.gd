extends Sprite2D

var bullet_tex3 = preload("res://resources/nebulaSmall.png")

var velocity = Vector2(-15, 0)

func _ready():
	position.x = randf_range(1,get_viewport_rect().size.x / 2) + get_viewport_rect().size.x / 3
	position.y = randf_range(50,get_viewport_rect().size.y - 50)
	texture = bullet_tex3

func _physics_process(delta):
	position += velocity * delta
	rotate(0.06 * delta)
	
	if (position.x <= -50):
		velocity.x *= -1
	if (position.x > get_viewport_rect().size.x):
		velocity.x *= -1
		

extends Sprite

var bullet_tex3 = preload("res://resources/nebulaSmall.png")

func _ready():
	position.x = rand_range(1,get_viewport_rect().size.x)
	position.y = rand_range(50,get_viewport_rect().size.y - 50)
	texture = bullet_tex3

func _physics_process(delta):
	position.x -= 10 * delta
	rotate(0.1 * delta)
	
	if (position.x <= -50):
			position.x = int(get_viewport_rect().size.x) + 50
			position.y = rand_range(50,get_viewport_rect().size.y - 50)

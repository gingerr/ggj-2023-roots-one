extends Node2D


# Declare member variables here. Examples:
const NUMBER_OF_STARS = 400
const singleton_vector = Vector2(1, 1)
const singleton_color = Color(1, 1, 1)

var stars:PoolVector2Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in range(NUMBER_OF_STARS):
		var pos_X = rand_range(1,get_viewport_rect().size.x)
		var pos_Y = rand_range(1,get_viewport_rect().size.y)
		stars.append(Vector2(pos_X, pos_Y))

func _physics_process(delta):
	for i in range(NUMBER_OF_STARS):
		var intensity = float(i % 5 + 1) / 5 # 0.2, 0.4, 0.6, 0.8, 1.0
		var star = stars[i]
		star.x -= 100 * delta * intensity
		if (star.x <= 0):
			star.x = int(get_viewport_rect().size.x)
			star.y = int(rand_range(1,get_viewport_rect().size.y))
		stars[i] = Vector2(star.x, star.y)
	update()

func _draw():
	for i in range(NUMBER_OF_STARS):
		var intensity = float(i % 5 + 1) / 5 # 0.2, 0.4, 0.6, 0.8, 1.0
		var star = stars[i]
		singleton_color.r = intensity 
		singleton_color.g = intensity 
		singleton_color.b = intensity 
		singleton_vector.x = star.x + 2
		singleton_vector.y = star.y
		draw_line(star, singleton_vector, singleton_color, 2.0, false) 
		
	
#func _process(delta):
#	pass

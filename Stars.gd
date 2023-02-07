extends Node2D


# Declare member variables here. Examples:
const NUMBER_OF_STARS = 10000
const singleton_vector = Vector2(1, 1)
const singleton_color = Color(1, 1, 1)
const horzontal_movement_speed = 100
const intensity_map = {
	0 : 0.2,
	1 : 0.4,
	2 : 0.6,
	3 : 0.8,
	4 : 1.0
}
const intensity_map_with_speed = {
	0 : 0.2 * horzontal_movement_speed,
	1 : 0.4 * horzontal_movement_speed,
	2 : 0.6 * horzontal_movement_speed,
	3 : 0.8 * horzontal_movement_speed,
	4 : 1.0 * horzontal_movement_speed
}
const star_paint_width = 2.0

var stars:PoolVector2Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	for i in range(NUMBER_OF_STARS):
		var pos_X = rand_range(1,get_viewport_rect().size.x)
		var pos_Y = rand_range(1,get_viewport_rect().size.y)
		stars.append(Vector2(pos_X, pos_Y))

func _physics_process(delta):
	var end_of_screen = int(get_viewport_rect().size.x)
	for i in range(NUMBER_OF_STARS):
		# performance optimization, lookup instead of float(i % 5 + 1) / 5
		var intensity = intensity_map_with_speed[i % 5]
		var star = stars[i]
		# performance optimization:  instead of speed * delta * intensity, pre multiplied intensity * speed
		star.x -= delta * intensity
		if (star.x <= 0):
			star.x = end_of_screen
			star.y = int(rand_range(1,get_viewport_rect().size.y))
		# Performance optimization, array object must be reset, but even same object works.. 
		# creation of new object would be slower stars[i] = Vector2(star.x, star.y)
		stars[i] = star 

	# performance optimization => less redraw
	if (Engine.get_physics_frames() % 3) == 0:
		update()

func _draw():
	for i in range(NUMBER_OF_STARS):
		# performance optimization, lookup instead of float(i % 5 + 1) / 5
		var intensity = intensity_map[i % 5]
		var star = stars[i]
		singleton_color.r = intensity 
		singleton_color.g = intensity 
		singleton_color.b = intensity 
		singleton_vector.x = star.x + 2
		singleton_vector.y = star.y
		draw_line(star, singleton_vector, singleton_color, star_paint_width, false) 

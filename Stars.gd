extends Node2D

const NUMBER_OF_STARS = 500
const horzontal_movement_speed = 100
const brightnessArray = [
	Color(0.2, 0.2, 0.2),
	Color(0.4, 0.4, 0.4),
	Color(0.6, 0.6, 0.6),
	Color(0.8, 0.8, 0.8),
	Color(1.0, 1.0, 1.0),
]
const intensity_map_with_speed = {
	0 : 0.2 * horzontal_movement_speed,
	1 : 0.4 * horzontal_movement_speed,
	2 : 0.6 * horzontal_movement_speed,
	3 : 0.8 * horzontal_movement_speed,
	4 : 1.0 * horzontal_movement_speed
}
var stars		= []
var colors 	= []

# Called when the node enters the scene tree for the first time.
func _ready():
	print(stars.size())
	randomize()
	var vector = Vector2(0, 0)
	for i in range(NUMBER_OF_STARS):
		var pos_X = rand_range(1, get_viewport_rect().size.x)
		var pos_Y = rand_range(1, get_viewport_rect().size.y)
		
		vector.x = pos_X
		vector.y = pos_Y
		stars.append(vector)
		
		vector.x = pos_X + 2
		vector.y = pos_Y
		stars.append(vector)
		
		var brightness = brightnessArray[i % 5]
		colors.append(brightness)
		colors.append(brightness)

func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	for i in range(NUMBER_OF_STARS):
		var double_i = i * 2
		var speed = intensity_map_with_speed[i % 5]
		var from = stars[double_i]
		from.x -= delta * speed
		if (from.x <= 0):
			from.x = screen_size.x
			from.y = rand_range(1, screen_size.y)
		var to = stars[double_i + 1]
		to.x = from.x + 2
		to.y = from.y
		stars[double_i] 		= from
		stars[double_i + 1] 	= to
	update()

func _draw():
	draw_multiline_colors(stars, colors, 1.0, false) 

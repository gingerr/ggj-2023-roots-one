extends Control

const star_number 		= 1000
const star_width 		= 2.0
const batch_number 		= 5
const batch_size 		= star_number / batch_number

const horzontal_movement_speed = 200

const intensity_map_with_speed = {
	0 : 0.2 * horzontal_movement_speed,
	1 : 0.4 * horzontal_movement_speed,
	2 : 0.6 * horzontal_movement_speed,
	3 : 0.8 * horzontal_movement_speed,
	4 : 1.0 * horzontal_movement_speed
}

# arrays for stars per brightness
var stars_0_2 		= []
var stars_0_4 		= []
var stars_0_6 		= []
var stars_0_8 		= []
var stars_1_0 		= []

# Called when the node enters the scene tree for the first time.
func _ready():
	stars_0_2.resize(batch_size * 2)
	stars_0_4.resize(batch_size * 2)
	stars_0_6.resize(batch_size * 2)
	stars_0_8.resize(batch_size * 2)
	stars_1_0.resize(batch_size * 2)
	randomize()
	var vector = Vector2(0, 0)
	var batch_index = 0;
	var array = get_array_by_star_index(0);
	for i in range(star_number):
		var pos_X = rand_range(1, get_viewport_rect().size.x)
		var pos_Y = rand_range(1, get_viewport_rect().size.y)

		if (batch_index == batch_size):
			batch_index = 0
			array = get_array_by_star_index(i);
		
		vector.x = pos_X
		vector.y = pos_Y
		array[2 * batch_index] = vector
		
		vector.x = pos_X + star_width
		vector.y = pos_Y
		array[2 * batch_index + 1] = vector
		batch_index += 1

func get_array_by_star_index(index):
	var array_number = index / batch_size 
	if (array_number == 0):
		return stars_0_2
	elif (array_number == 1):
		return stars_0_4
	elif (array_number == 2):
		return stars_0_6
	elif (array_number == 3):
		return stars_0_8
	elif (array_number == 4):
		return stars_1_0
			
func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	var batch_index = 0;
	var array = get_array_by_star_index(0);
	for i in range(star_number):
		if (batch_index == batch_size):
			batch_index = 0
			array = get_array_by_star_index(i);
	
		var array_number = i / batch_size 
		var speed = intensity_map_with_speed[array_number]
		
		var from = array[2 * batch_index]
		from.x -= delta * speed
		if (from.x <= 0):
			from.x = screen_size.x
			from.y = rand_range(1, screen_size.y)
		var to = array[2 * batch_index + 1]
		to.x = from.x + star_width
		to.y = from.y
		array[2 * batch_index] 		= from
		array[2 * batch_index + 1] 	= to
		batch_index += 1
	update()

func _draw():
	draw_multiline(stars_0_2, Color(0.2, 0.2, 0.2), 1.0, false) 
	draw_multiline(stars_0_4, Color(0.4, 0.4, 0.4), 1.0, false) 
	draw_multiline(stars_0_6, Color(0.6, 0.6, 0.6), 1.0, false) 
	draw_multiline(stars_0_8, Color(0.8, 0.8, 0.8), 1.0, false) 
	draw_multiline(stars_1_0, Color(1.0, 1.0, 1.0), 1.0, false) 

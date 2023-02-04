extends Sprite

var textures = Array ([
	preload("resources/asteroid1.png"), 
	preload("resources/asteroid2.png"),
	preload("resources/asteroid3.png"),
	preload("resources/asteroid4.png"),
	])

func _ready():
	randomize()
	var rand_index:int = randi() % textures.size()
	texture = textures[rand_index]


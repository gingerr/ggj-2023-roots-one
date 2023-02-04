extends Node

<<<<<<< HEAD
=======
const drift_in_pixel = 1

>>>>>>> 09ecef3 (.)
var timer = 0

func _process(delta):
		# objects in space are drifting slightly
	timer += delta;
	if timer > 0.2:
		var parent = get_parent();
		var drift_x = int(rand_range(0, 2*drift_in_pixel + 1)) - drift_in_pixel
		var drift_y = int(rand_range(0, 2*drift_in_pixel + 1)) - drift_in_pixel
		parent.position.x += drift_x
		parent.position.y += drift_y
		timer = 0

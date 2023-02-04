extends Node

var timer = 0

func _process(delta):
		# objects in space are drifting slightly
	timer += delta;
	if timer > 0.2:
		var parent = get_parent();
		parent.position.x += int(rand_range(1,4)) - 2
		parent.position.y += int(rand_range(1,4)) - 2
		timer = 0

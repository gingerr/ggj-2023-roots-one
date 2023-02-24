extends Node2D


func _ready():
	get_tree().root.size_changed.connect(set_dynamic_configuration)
	set_dynamic_configuration()

func set_dynamic_configuration():
	var viewportSize: Vector2 = get_viewport_rect().size
	var width: float = viewportSize.x
	var halfHeight: float = viewportSize.y / 2
	
	# readjust the particles parent node position
	position.x = width
	position.y = halfHeight
	
	for emitter in get_children() as Array[CPUParticles2D]:		
		# emission shape: set new vertical middle
		emitter.set_emission_rect_extents(Vector2(0, halfHeight))
		
		# time: set new lifetime & preprocess according to their speed
		var lifetime: float = width / emitter.initial_velocity_min
		emitter.set_lifetime(lifetime)
		emitter.set_pre_process_time(lifetime)
		
		# restart: otherwise the particles would need some time to re-fill the viewport
		emitter.restart()


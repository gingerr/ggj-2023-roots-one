extends CPUParticles2D

func _ready():
	one_shot = true
	emitting = true
	if $Sound: 
		$Sound.global_position = self.global_position
		$Sound.play(0.1)

func _process(delta):
	if !emitting && (!$Sound || !$Sound.is_playing()):
		queue_free()
	else:
		yield()

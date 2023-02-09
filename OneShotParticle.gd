extends CPUParticles2D

func _ready():
	emitting = true
	$Sound.global_position = self.global_position
	$Sound.play(0.1)

func _process(delta):
	if !emitting && $Sound.is_playing():
		queue_free()

extends CanvasLayer

var tween: Tween = null

func colorModulate(color: Color):
	var mat: ShaderMaterial = $ColorRect.material
	# we divide the colors by 2 since gray will look neutral if the overlay shader is used
	mat.set_shader_parameter('overlay', Vector3(color.r / 2, color.g / 2, color.b / 2))

func flash(color: Color, keepTargetColor: bool):
	if tween:
		tween.kill()
	
	tween = $ColorRect.create_tween()
	tween.tween_property($ColorRect.material, "shader_parameter/overlay", Vector3(0.5, 0.5, 0.5), 0.05).set_ease(Tween.EASE_OUT)
	tween.tween_property($ColorRect.material, "shader_parameter/overlay", Vector3(color.r, color.g, color.b), 0.05).set_ease(Tween.EASE_OUT)
	
	if !keepTargetColor:
		tween.tween_property($ColorRect.material, "shader_parameter/overlay", Vector3(0.5, 0.5, 0.5), 2).set_ease(Tween.EASE_OUT)

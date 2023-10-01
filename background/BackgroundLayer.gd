extends CanvasLayer

var tween: Tween = null

func colorModulate(color: Color):
	$CanvasModulate.color = color;

func flash(color: Color, keepTargetColor: bool):
	if tween:
		tween.kill()
	
	tween = $CanvasModulate.create_tween()
	tween.tween_property($CanvasModulate, 'color', Color.WHITE, 0.05).set_ease(Tween.EASE_OUT)
	tween.tween_property($CanvasModulate, 'color', color, 0.05).set_ease(Tween.EASE_OUT)
	if !keepTargetColor:
		tween.tween_property($CanvasModulate, 'color', Color.WHITE, 2).set_ease(Tween.EASE_OUT)

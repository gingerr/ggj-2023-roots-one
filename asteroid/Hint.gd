extends Area2D

var transparency = 1.0;

func set_text(text):
	$label.text = text

func _process(delta):
	print("Tst")
	transparency -= 0.5 * delta
	$label.set("theme_override_colors/font_color", Color(1 ,0, 0, transparency))
	if (transparency < 0):
		queue_free()

class_name Utils
extends Node

static func randomBoolean():
	if randi() % 2:
		return true
	return false
	
static func default_font_color(label : Label):
	label.set("custom_colors/font_color", Color(0.2,0.9,0.2))

class_name Utils
extends Node

static func randomBoolean():
	if randi() % 2:
		return true
	return false
	
static func default_font_color(label : Label):
	label.set("theme_override_colors/font_color", Color(1,0.7,0.0))

static func button_selected(label : Button):
	label.set("theme_override_colors/font_color", Color(1.0,0.7,0.0))
	label.set("theme_override_colors/font_color_hover", Color(1.0,0.7,0.0))

static func button_not_selected(label : Button):
	label.set("theme_override_colors/font_color", Color(1,1,1))
	label.set("theme_override_colors/font_color_hover", Color(1,1,1))

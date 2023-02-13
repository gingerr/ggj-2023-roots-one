extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var text = load_text_file('res://pregame/res/story.tres')
	Utils.default_font_color($MarginContainer/VBoxContainer/Label)
	$MarginContainer/VBoxContainer/Label.set_text(text)

func _input(event: InputEvent):
	if event.get('pressed') and event.pressed:
		get_tree().change_scene_to_file("res://game/Game.tscn")
		

func load_text_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file.get_error() != OK:
		printerr("Could not open file, error code ", file.get_error())
		return ""
		
	var stext = file.get_as_text()
	return stext

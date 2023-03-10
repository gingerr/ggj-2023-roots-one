extends Node

func _ready():
	var text = Utils.load_text_file('res://pregame/res/story.tres')
	%Label.set_text(text)

func _unhandled_input(event: InputEvent):
	if event.get('pressed'):
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file("res://game/Game.tscn")
		

func load_text_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file.get_error() != OK:
		printerr("Could not open file, error code ", file.get_error())
		return ""
		
	var stext = file.get_as_text()
	return stext

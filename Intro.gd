extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var text = load_text_file('res://resources/story.tres')
	var node: Label = get_node('%Label')
	node.set_text(text)
	Utils.default_font_color(node)

func _input(event: InputEvent):
	if event.get('pressed') and event.pressed:
		get_tree().change_scene("res://Game.tscn")

func load_text_file(path):
	var f = File.new()
	var err = f.open(path, File.READ)
	if err != OK:
		printerr("Could not open file, error code ", err)
		return ""
		
	var stext = f.get_as_text()
	f.close()
	return stext

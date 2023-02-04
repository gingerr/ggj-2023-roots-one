extends Node

func _ready():
	var text = load_text_file('res://resources/story.tres')
	var node: Label = get_node('%Label')
	node.set_text(text)

func _input(event: InputEvent):
	if event.get('pressed') and event.pressed:
		get_tree().change_scene("res://Game.tscn")
		
	pass

func load_text_file(path):
	var f = File.new()
	var err = f.open(path, File.READ)
	if err != OK:
		printerr("Could not open file, error code ", err)
		return ""
		
	var stext = f.get_as_text()
	f.close()
	return stext
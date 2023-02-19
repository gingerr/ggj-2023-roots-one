class_name Utils
extends Resource

static func randomBoolean():
	if randi() % 2:
		return true
	return false
	
static func load_text_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file.get_error() != OK:
		printerr("Could not open file, error code ", file.get_error())
		return ""
		
	var stext = file.get_as_text()
	return stext

class_name Utils
extends Resource

static func randomBoolean():
	if randi() % 2:
		return true
	return false
	
static func load_text_file(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if !file:
		printerr("Could not open file, error code ", FileAccess.get_open_error())
		return ""
		
	var stext = file.get_as_text()
	file.close()
	return stext

static func save_text_file(path: String, content: String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	if !file:
		printerr("Could not open file, error code ", FileAccess.get_open_error())
		return ""
	
	file.store_string(content)
	file.close()

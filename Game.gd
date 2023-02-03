extends Node2D


enum DISPLAY_MODE {
	WINDOW
	FULLSCREEN
}

var DEFAULT_SCREEN_MODE = DISPLAY_MODE.WINDOW

func _ready():
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.WINDOW):
		OS.set_window_size(OS.get_screen_size() * 0.9)
		OS.set_window_position(
			OS.get_screen_position(OS.get_current_screen()) + 
			OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.FULLSCREEN):
		OS.window_fullscreen = true

#func _process(delta):
#	pass

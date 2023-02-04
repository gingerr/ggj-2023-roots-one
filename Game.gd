extends Node2D


enum DISPLAY_MODE {
	WINDOW
	FULLSCREEN
}

var DEFAULT_SCREEN_MODE = DISPLAY_MODE.FULLSCREEN
onready var squareRootFactory = preload("res://SquareRootMob.tscn")

func _ready():
	# todo extract into mob spawn manager
	call_deferred("spawnSquareRoot", 0.2, 0.1, '361')
	call_deferred("spawnSquareRoot", 0.7, 0.05, '256')
	
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.WINDOW):
		
		OS.set_window_size(OS.get_screen_size() * 0.9)
		OS.set_window_position(
			OS.get_screen_position(OS.get_current_screen()) + 
			OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.FULLSCREEN):
		OS.window_fullscreen = true

#func _process(delta):
#	pass

# todo wip
func spawnSquareRoot(verticalPosition: float, scale: float, text: String):
	var mob = squareRootFactory.instance()
	var x = get_viewport_rect().size.x
	var y = get_viewport_rect().size.y * verticalPosition
	mob.global_position = Vector2(x, y)
	mob.scale = Vector2(scale, scale)
	mob.set_text(text)
	get_tree().root.add_child(mob)

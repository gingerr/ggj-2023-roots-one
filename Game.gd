extends Node2D


enum DISPLAY_MODE {
	WINDOW
	FULLSCREEN
}

var difficulty_level = 10;

var DEFAULT_SCREEN_MODE = DISPLAY_MODE.FULLSCREEN
onready var squareRootFactory = preload("res://EnemyRoot.tscn")
onready var background = preload("res://BackgroundLayer.tscn")

func _ready():
	add_child(background.instance())
	# todo extract into mob spawn manager
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")

func _init():
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.WINDOW):
		OS.set_window_size(OS.get_screen_size() * 0.9)
		OS.set_window_position(
			OS.get_screen_position(OS.get_current_screen()) + 
			OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	if (DEFAULT_SCREEN_MODE == DISPLAY_MODE.FULLSCREEN):
		OS.window_fullscreen = true

func spawnEnemy():
	var text = "123"
	var mob = squareRootFactory.instance()
	var x = get_viewport_rect().size.x
	var y = get_viewport_rect().size.y * 0.5
	mob.global_position = Vector2(x, y)
	#mob.scale = Vector2(scale, scale)
	mob.set_text(text)
	get_tree().root.add_child(mob)

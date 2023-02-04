extends Node2D


enum DISPLAY_MODE {
	WINDOW
	FULLSCREEN
}


const spawn_interval_in_seconds = 3
var spawn_timer 				= 0
var difficulty_level = 100;

var DEFAULT_SCREEN_MODE = DISPLAY_MODE.FULLSCREEN
onready var squareRootFactory = preload("res://EnemyRoot.tscn")
onready var background = preload("res://BackgroundLayer.tscn")

func _ready():
	add_child(background.instance())
	# todo extract into mob spawn manager
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")
	call_deferred("spawnEnemy")
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

func _process(delta):
	if (Input.is_key_pressed(KEY_ESCAPE)):
		#get_tree().quit()
		get_tree().paused = true
		get_tree().change_scene("res://MainMenu.tscn")
	
	spawn_timer += delta;
	if (spawn_timer > spawn_interval_in_seconds):
		spawn_timer = 0;
		call_deferred("spawnEnemy")
		

func spawnEnemy():
	var mob = squareRootFactory.instance()
	mob.configure(difficulty_level)
	get_tree().root.add_child(mob)

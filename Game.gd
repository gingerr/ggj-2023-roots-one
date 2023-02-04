extends Node2D

# difficulty configuration
const intial_root_number 		= 100;
const spawn_interval_in_seconds = 5 
const level_interval_in_seconds = 10
var spawn_amount 				= 4
var max_root_number 			= intial_root_number
export var level 				= 1

# timer variables
var spawn_timer 				= 3
var level_timer 				= 0

onready var squareRootFactory = preload("res://EnemyRoot.tscn")

func _enter_tree():
	HUD.setVisibility(true)
	
func _exit_tree():
	HUD.setVisibility(false)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	spawn_timer += delta;
	level_timer += delta;
	if (spawn_timer > spawn_interval_in_seconds):
		spawn_timer = 0;
		max_root_number = intial_root_number + level * 10
		for i in range(spawn_amount):
			call_deferred("spawnEnemy")
	if (level_timer > level_interval_in_seconds):
		level_timer = 0;
		level +=1
		HUD.setLevel(level)


func spawnEnemy():
	var mob = squareRootFactory.instance()
	mob.configure(max_root_number)
	get_tree().root.add_child(mob)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
#		get_tree().quit()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		get_tree().change_scene("res://MainMenu.tscn")

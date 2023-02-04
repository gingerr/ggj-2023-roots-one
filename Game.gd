extends Node2D

# difficulty configuration
var spawn_amount 				= 4
var spawn_interval_in_seconds   = 5 
var max_root_number 			= 100
var level 						= 1

var spawn_timer 				= 5

onready var squareRootFactory = preload("res://EnemyRoot.tscn")

func _process(delta):
	spawn_timer += delta;
	if (spawn_timer > spawn_interval_in_seconds):
		spawn_timer = 0;
		for i in range(spawn_amount):
			call_deferred("spawnEnemy")
		max_root_number += 10

func spawnEnemy():
	var mob = squareRootFactory.instance()
	mob.configure(max_root_number)
	get_tree().root.add_child(mob)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
#		get_tree().quit()
		get_tree().paused = true
		get_tree().change_scene("res://MainMenu.tscn")

extends Node2D

const spawn_amount 				= 2
const spawn_interval_in_seconds = 5
var difficulty_level 			= 100;


var spawn_timer 				= 5

onready var squareRootFactory = preload("res://EnemyRoot.tscn")

func _process(delta):
	spawn_timer += delta;
	if (spawn_timer > spawn_interval_in_seconds):
		spawn_timer = 0;
		for i in range(spawn_amount):
			print(i)
			call_deferred("spawnEnemy")

func spawnEnemy():
	var mob = squareRootFactory.instance()
	mob.configure(difficulty_level)
	get_tree().root.add_child(mob)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
#		get_tree().quit()
		get_tree().paused = true
		get_tree().change_scene("res://MainMenu.tscn")

extends Node2D


const spawn_interval_in_seconds = 3
var spawn_timer 				= 0
var difficulty_level = 100;

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
	pass

func _process(delta):
	spawn_timer += delta;
	if (spawn_timer > spawn_interval_in_seconds):
		spawn_timer = 0;
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

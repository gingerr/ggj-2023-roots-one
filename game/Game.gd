extends CanvasLayer

# difficulty configuration
const intial_root_number 		= 100;
const level_interval_in_seconds = 10
var spawn_interval_in_seconds 	= 5

var spawn_amount 				= 2
var max_root_number 			= intial_root_number
@export var level 				= 1

# timer variables
var spawn_timer 				= 3
var level_timer 				= 0

const squareRootFactory = preload("res://asteroid/EnemyRoot.tscn")
const gameOverPreload = preload("res://game/GameOver.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$HUD.setLevel(level)
	
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
		increaseLevel()

func increaseLevel():
	level +=1
	$HUD.setLevel(level)
	if level == 5:
		spawn_amount += 1
	elif level == 10:
		spawn_interval_in_seconds -= 1
	elif level == 15:
		spawn_amount += 1
		spawn_interval_in_seconds += 1
	

func spawnEnemy():
	var mob: EnemyRoot = squareRootFactory.instantiate()
	mob.safeZoneTop = $HUD.topHeight
	mob.safeZoneBottom = $HUD.bottomHeight
	mob.configure(max_root_number)
	mob.scored.connect(_on_enemy_root_scored)
	add_child(mob)

func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_tree().paused = true
		$PauseScreen.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Player_dead():
	var gameOver = gameOverPreload.instantiate()
	gameOver.score = $HUD.score
	gameOver.time = $HUD.getTimeString()
	$HUD.visible = false
	add_child(gameOver)

func _on_player_health_changed(value: int):
	$HUD.setHealth(value)

func _on_player_max_health_changed(value: int):
	$HUD.setMaxHealth(value)

func _on_enemy_root_scored():
	$HUD.increaseScore(1)

func _on_player_shield_changed(value: float):
	$HUD.set_shield(value)
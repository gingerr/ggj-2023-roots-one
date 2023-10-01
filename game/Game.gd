extends CanvasLayer

# difficulty configuration
const initial_root_number 		= 100
const second_wave_enemy_spawn_wait_time = 5

var spawn_amount 				= 2
var max_root_number 			= initial_root_number
@export var level 				= 1

const squareRootFactory = preload("res://asteroid/EnemyRoot.tscn")
const sanityFactory = preload("res://pickups/sanity.tscn")
const gameOverPreload = preload("res://game/GameOver.tscn")

func _ready():
	$HUD.setLevel(level)

func _enter_tree():
	$BackgroundLayer.colorModulate(Color.WHITE)
	if not DisplayServer.is_touchscreen_available():
		$MobileControls.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func increaseLevel():
	level +=1
	$HUD.setLevel(level)
	if level == 5:
		spawn_amount += 1
	elif level == 10:
		$EnemySpawnTimer.wait_time -= 1
	elif level == 15:
		spawn_amount += 1
		$EnemySpawnTimer.wait_time += 1
	
func spawnEnemyWave():
	max_root_number = initial_root_number + level * 10
	for i in range(spawn_amount):
		call_deferred("spawnEnemy")

func spawnEnemy():
	var mob: EnemyRoot = squareRootFactory.instantiate()
	mob.safeZoneTop = $HUD.topHeight
	mob.safeZoneBottom = $HUD.bottomHeight
	mob.configure(max_root_number)
	mob.scored.connect(_on_enemy_root_scored)
	mob.wrong_hit.connect(_on_enemy_root_wrong_hit)
	add_child(mob)

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		get_viewport().set_input_as_handled()
		$PauseScreen.visible = true

func _on_Player_dead():
	var gameOver = gameOverPreload.instantiate()
	gameOver.score = $HUD.score
	gameOver.time = $HUD.getTimeString()
	$HUD.visible = false
	add_child(gameOver)

func _on_player_health_changed(value: int, change: int, visualize: bool):
	var player: Player = $Player
	$HUD.setHealth(value)
	if visualize:
		var color: Color = Color.GREEN if change > 0 else Color.RED
		$BackgroundLayer.flash(color, value == 0)

func _on_player_max_health_changed(value: int):
	$HUD.setMaxHealth(value)

func _on_enemy_root_scored():
	$HUD.increaseScore(1)

func _on_enemy_root_wrong_hit():
	$Player.change_health(-1)

func _on_player_shield_changed(value: float):
	$HUD.set_shield(value)

func _on_touch_screen_button_pressed():
	%ShootButtonLabel.set_theme_type_variation("LabelOrange")

func _on_touch_screen_button_released():
	%ShootButtonLabel.set_theme_type_variation("")

func _on_pickup_spawn_timer_timeout():
	var pickup = sanityFactory.instantiate()
	add_child(pickup)

func _on_level_timer_timeout():
	increaseLevel()

func _on_enemy_spawn_timer_timeout():
	spawnEnemyWave()
	
	# when the game starts we have a initial shorter timing
	if $EnemySpawnTimer.wait_time == 2.222:
		$EnemySpawnTimer.wait_time = second_wave_enemy_spawn_wait_time

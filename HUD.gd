extends CanvasLayer

export var topHeight: int
export var bottomHeight: int
export var time: float
export var score: int
var health: int
var level = 1
var maxHealth: int

func _ready():
	setTopBottomHeight()
	setVisibility(false)
	resetGameValues()
	Utils.default_font_color(get_node('%Fps'))
	Utils.default_font_color(get_node('%Score'))
	Utils.default_font_color(get_node('%Time'))

func _process(delta: float):
	time += delta
	updateHUD()
	
func setVisibility(value: bool):
	get_node("MainContainer").visible = value
	
func get_score():
	return score
		
func increaseScore(value: int):
	score += value
	updateHUD()

func setMaxHealth(value: int):
	maxHealth = value
	updateHUD()

func setLevel(value: int):
	if (value >= 0):
		level = value
		updateHUD()
	
func setHealth(value: int):
	if (value >= 0):
		health = value
		updateHUD()

func playExplosion(position: Vector2):
	$ExplosionSound.global_position = position
	$ExplosionSound.play()

func updateHUD():
	get_node('%Fps').set_text("FPS: " + String(Engine.get_frames_per_second()))
	get_node('%Score').set_text('Score: ' + String(score) + ' (Level ' + String(level) + ')')
	get_node('%Time').set_text('Time: ' + getTimeString())
	var bar: ProgressBar = get_node('%Bar')
	
	
	bar.max_value = max(maxHealth, 1)
	bar.value = health
	var percentage = float(health) / float(max(maxHealth, 1))
	bar.get("custom_styles/fg").set_bg_color(Color (1.0 - percentage, percentage, 0))
	
func getTimeString() -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
	
func resetGameValues():
	time = 0.0
	score = 0
	updateHUD()
	
func setTopBottomHeight():
	var topSize = get_node('%Top').get_combined_minimum_size();
	var bottomSize = get_node('%Bottom').get_combined_minimum_size();
	topHeight = topSize.y;
	bottomHeight = bottomSize.y;

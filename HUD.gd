extends CanvasLayer

@export var topHeight: int
@export var bottomHeight: int
@export var time: float
@export var score: int
var health: int
var level = 1
var maxHealth: int
var shield = 0

func _ready():
	setTopBottomHeight()
	setVisibility(false)
	resetGameValues()
	Utils.default_font_color(get_node('%Fps'))
	Utils.default_font_color(get_node('%Score'))
	Utils.default_font_color(get_node('%Time'))

	var bar_shield: ProgressBar = $MainContainer/VBoxContainer/Bottom/Shield/ShieldBar
	bar_shield.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)
	bar_shield.max_value = 100

	var bar_sanity: ProgressBar = $MainContainer/VBoxContainer/Bottom/Sanity/SanityBar
	bar_sanity.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)

func _process(delta: float):
	time += delta
	updateHUD()
	
func setVisibility(value: bool):
	$MainContainer.visible = value
	
func get_score():
	return score
		
func increaseScore(value: int):
	score += value
	updateHUD()

func setMaxHealth(value: int):
	maxHealth = value
	shield = 0
	updateHUD()

func setLevel(value: int):
	if (value >= 0):
		level = value
		updateHUD()
	
func setHealth(value: int):
	if (value >= 0):
		health = value
		updateHUD()

func set_shield(value : float):
	shield = value

func get_shield() -> float: 
	return shield

func updateHUD():
	get_node('%Fps').set_text("FPS: " + str(Engine.get_frames_per_second()))
	get_node('%Score').set_text('Score: ' + str(score) + ' (Level ' + str(level) + ')')
	get_node('%Time').set_text('Time: ' + getTimeString())
	
	var bar_sanity: ProgressBar = $MainContainer/VBoxContainer/Bottom/Sanity/SanityBar
	bar_sanity.max_value = max(maxHealth, 1)
	bar_sanity.value = health
	var percentage_health = float(health) / float(max(maxHealth, 1))
	bar_sanity.get("theme_override_styles/fill").bg_color = Color (0.5 - percentage_health, 0.5 * percentage_health, 0, 0.5)
	
	var bar_shield: ProgressBar = $MainContainer/VBoxContainer/Bottom/Shield/ShieldBar
	var percentage_shield = float(shield) / 100.0
	bar_shield.get("theme_override_styles/fill").bg_color = Color (0.5 * percentage_shield, 0.5 * percentage_shield, 0.6 + 0.4 * percentage_shield, 0.5)
	bar_shield.value = shield
	
	if shield == 100.0:
		$MainContainer/VBoxContainer/Bottom/Shield/ShieldLabel.text = "Shield (ready)"
	else:
		$MainContainer/VBoxContainer/Bottom/Shield/ShieldLabel.text = "Shield (" + str(int(shield)) + " %)"
	
func getTimeString() -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
	
func resetGameValues():
	time = 0.0
	score = 0
	updateHUD()
	
func setTopBottomHeight():
	var topSize = $MainContainer/VBoxContainer/Top.get_combined_minimum_size();
	var bottomSize = $MainContainer/VBoxContainer/Bottom.get_combined_minimum_size();
	topHeight = topSize.y;
	bottomHeight = bottomSize.y;

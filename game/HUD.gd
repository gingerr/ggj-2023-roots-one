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
	Utils.default_font_color(%Fps)
	Utils.default_font_color(%Score)
	Utils.default_font_color(%Time)

	var bar_shield: ProgressBar = %ShieldBar
	bar_shield.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)
	bar_shield.max_value = 100

	var bar_sanity: ProgressBar = %SanityBar
	bar_sanity.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)

func _process(delta: float):
	time += delta
	updateHUD()
		
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

func updateHUD():
	%Fps.set_text("FPS: " + str(Engine.get_frames_per_second()))
	%Score.set_text('Score: ' + str(score) + ' (Level ' + str(level) + ')')
	%Time.set_text('Time: ' + getTimeString())
	
	var bar_sanity: ProgressBar = %SanityBar
	bar_sanity.max_value = max(maxHealth, 1)
	bar_sanity.value = health
	var percentage_health = float(health) / float(max(maxHealth, 1))
	bar_sanity.get("theme_override_styles/fill").bg_color = Color (0.5 - percentage_health, 0.5 * percentage_health, 0, 0.5)
	
	var bar_shield: ProgressBar = %ShieldBar
	var percentage_shield = float(shield) / 100.0
	bar_shield.get("theme_override_styles/fill").bg_color = Color (0.5 * percentage_shield, 0.5 * percentage_shield, 0.6 + 0.4 * percentage_shield, 0.5)
	bar_shield.value = shield
	
	if shield == 100.0:
		%ShieldLabel.text = "Shield (ready)"
	else:
		%ShieldLabel.text = "Shield (" + str(int(shield)) + " %)"
	
func getTimeString() -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
	
func setTopBottomHeight():
	var topSize = %Top.get_combined_minimum_size();
	var bottomSize = %Bottom.get_combined_minimum_size();
	topHeight = topSize.y;
	bottomHeight = bottomSize.y;

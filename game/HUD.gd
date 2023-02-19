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
	%ShieldBar.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)
	%SanityBar.get("theme_override_styles/background").bg_color = Color (0.2, 0.2, 0.2, 0.5)

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
	
	%SanityBar.max_value = max(maxHealth, 1)
	%SanityBar.value = health
	var percentage_health = float(health) / float(max(maxHealth, 1))
	%SanityBar.get("theme_override_styles/fill").bg_color = Color (0.5 - percentage_health, 0.5 * percentage_health, 0, 1)
	
	var percentage_shield = float(shield) / 100.0
	%ShieldBar.get("theme_override_styles/fill").bg_color = Color (0.5 * percentage_shield, 0.5 * percentage_shield, 0.6 + 0.4 * percentage_shield, 1)
	%ShieldBar.value = shield
	
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

extends CanvasLayer

export var topHeight: int
export var bottomHeight: int
export var time: float
export var score: int

func _ready():
	setTopBottomHeight()
	resetGameValues()

func _process(delta: float):
	time += delta
	updateHUD()
	
func increaseScore(value: int) :
	score += value
	updateHUD()

func updateHUD():
	get_node('%Fps').set_text("FPS: " + String(Engine.get_frames_per_second()))
	get_node('%Score').set_text('Score: ' + String(score))
	get_node('%Time').set_text('Time: ' + getTimeString())
	
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

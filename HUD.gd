extends HBoxContainer

export var time: float
export var score: int

func _ready():
	time = 0
	score = 0
	$Timer.start()
	updateHUD()

func _process(delta: float):
	time += delta
	updateHUD()
	
func increaseScore(value: int) :
	score = value
	updateHUD()

func updateHUD():
	$Fps.set_text("FPS: " + String(Engine.get_frames_per_second()))
	$Score.set_text('Score: ' + String(score))
	$Time.set_text('Time: ' + getTimeString())
	
func getTimeString() -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]

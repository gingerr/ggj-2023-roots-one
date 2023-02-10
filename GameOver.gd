extends PanelContainer

var timer_done = false

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	get_tree().paused = true;
	if !timer_done:
		$VBoxContainer/Countdown.text = "Your score:\n" + str(HUD.get_score()) + " points\n\n  Waiting for " + String(round($Timer.time_left)) + " seconds  \n"
	else:
		$VBoxContainer/Countdown.text = "Your score:\n" + str(HUD.get_score()) + " points\n\n  <any key to continue>  \n"	

func _input(event: InputEvent):
	if timer_done and event.get('pressed') and event.pressed:
		get_tree().paused = false;
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		
func _on_Timer_timeout():
	timer_done = true

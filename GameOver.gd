extends CanvasLayer

var timer_done = false

func _ready():
	$AudioStreamPlayer.play()
	Utils.default_font_color($CenterContainer/VBoxContainer/Countdown)
	Utils.default_font_color($CenterContainer/VBoxContainer/Label)

func _process(delta):
	get_tree().paused = true;
	if !timer_done:
		$CenterContainer/VBoxContainer/Countdown.text = "Your score:\n" + str(HUD.get_score()) + " points\n\n  Waiting for " + str(round($Timer.time_left)) + " seconds  \n"
	else:
		$CenterContainer/VBoxContainer/Countdown.text = "Your score:\n" + str(HUD.get_score()) + " points\n\n  <any key to continue>  \n"	

func _input(event: InputEvent):
	if timer_done and event.get('pressed') and event.pressed:
		get_tree().paused = false;
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		
func _on_Timer_timeout():
	timer_done = true

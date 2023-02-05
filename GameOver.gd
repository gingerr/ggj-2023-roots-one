extends PanelContainer

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	get_tree().paused = true;
	$VBoxContainer/Countdown.text = "Your score:\n" + str(HUD.get_score()) + " points\n\n  Exiting in " + String(round($Timer.time_left)) + " seconds  \n"

func _on_Timer_timeout():
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://MainMenu.tscn")

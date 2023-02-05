extends PanelContainer

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	$VBoxContainer/Countdown.text = String(round($Timer.time_left))

func _on_Timer_timeout():
	get_tree().change_scene("res://MainMenu.tscn")

extends CanvasLayer

@export var score: int = 0
@export var time: String = ''
var timer_done = false

func _ready():
	$AudioStreamPlayer.play()
	Utils.default_font_color(get_node('%Title'))
	get_node('%Score').text = "Your score:\n" + str(score) + " points"
	get_node('%Time').text = "Your time:\n" + time

func _process(delta):
	get_tree().paused = true;
	if !timer_done:
		get_node('%Countdown').text = "Waiting for " + str(round($Timer.time_left)) + " seconds"
	else:
		get_node('%Countdown').text = "<any key to continue>"

func _input(event: InputEvent):
	if timer_done and event.get('pressed') and event.pressed:
		get_viewport().set_input_as_handled()
		get_tree().paused = false;
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://pregame/MainMenu.tscn")
		
func _on_Timer_timeout():
	timer_done = true

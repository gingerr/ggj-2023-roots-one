extends MarginContainer


onready var background = preload("res://BackgroundLayer.tscn")


func _ready():
	add_child(background.instance())
	OS.window_fullscreen = true

func _process(delta):
	if (get_tree().paused):
		$Selection/Continue.disabled = false
	else:
		$Selection/Continue.disabled = true

func _on_ButtonNewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Game.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Game.tscn")

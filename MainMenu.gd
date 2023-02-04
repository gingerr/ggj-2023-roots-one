extends MarginContainer


onready var background = preload("res://BackgroundLayer.tscn")


func _ready():
	add_child(background.instance())
	OS.window_fullscreen = true

func _process(delta):
	if (get_tree().paused):
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = false
	else:
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = true

func _on_ButtonNewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Game.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Continue_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Game.tscn")


func _on_Options_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = true
	$VBoxContainer/MarginContainer/Selection.visible = false


func _on_BackToMain_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = false
	$VBoxContainer/MarginContainer/Selection.visible = true

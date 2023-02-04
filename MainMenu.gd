extends MarginContainer


onready var background = preload("res://BackgroundLayer.tscn")


func _ready():
	add_child(background.instance())

func _process(delta):
	if (get_tree().paused):
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = false
	else:
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = true

func _on_NewGame_pressed():
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

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		_on_Continue_pressed()

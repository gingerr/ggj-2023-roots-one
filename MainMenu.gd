extends MarginContainer


onready var newGame = $HBoxContainer/Selection/NewGame


func _ready():
	OS.window_fullscreen = true

#func _process(delta):
#	pass

func _on_ButtonNewGame_pressed():
	get_tree().change_scene("res://Game.tscn")

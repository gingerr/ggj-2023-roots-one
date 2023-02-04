extends Node

func _input(event: InputEvent):
	if event.get('pressed') and event.pressed:
		get_tree().change_scene("res://Game.tscn")
		
	pass

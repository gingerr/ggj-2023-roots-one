extends MarginContainer

func _ready():
	%NewGame.grab_focus()

func _on_NewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://pregame/Intro.tscn")
	
func _on_Options_pressed():
	%OptionsMenu.visible = true
	%Selection.visible = false
	%BackToMain.grab_focus()

func _on_Exit_pressed():
	get_tree().quit()

func _on_BackToMain_pressed():
	%OptionsMenu.visible = false
	%Selection.visible = true
	%NewGame.grab_focus()

func _on_new_game_mouse_entered():
	%NewGame.grab_focus()
	
func _on_options_mouse_entered():
	%Options.grab_focus()

func _on_exit_mouse_entered():
	%Exit.grab_focus()

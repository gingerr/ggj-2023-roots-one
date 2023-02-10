extends MarginContainer

var selectionIndex = 0;

func _on_NewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Intro.tscn")


func _on_Exit_pressed():
	get_tree().quit()

func _ready():
	Utils.default_font_color($VBoxContainer/copyright)
	visualize_selection()

func _on_Options_pressed():
	$HBoxContainer/VBoxContainer/MarginContainer/OptionsMenu.visible = true
	$HBoxContainer/VBoxContainer/MarginContainer/Selection.visible = false

func _on_BackToMain_pressed():
	$HBoxContainer/VBoxContainer/MarginContainer/OptionsMenu.visible = false
	$HBoxContainer/VBoxContainer/MarginContainer/Selection.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouse: 
		if $HBoxContainer/VBoxContainer/MarginContainer/Selection/NewGame.is_hovered():
			selectionIndex = 0;
		elif $HBoxContainer/VBoxContainer/MarginContainer/Selection/Exit.is_hovered():
			selectionIndex = 1;
	#if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
	if Input.is_action_pressed("ui_accept"):
		match selectionIndex:
			0: 
				$HBoxContainer/VBoxContainer/MarginContainer/Selection/NewGame.emit_signal("pressed")
			1: 
				$HBoxContainer/VBoxContainer/MarginContainer/Selection/Exit.emit_signal("pressed")
		
	#if event is InputEventKey and event.pressed and event.keycode == KEY_DOWN:
	if Input.is_action_pressed("ui_down"):
		selectionIndex = min(selectionIndex + 1, 1)
	#if event is InputEventKey and event.pressed and event.keycode == KEY_UP:
	if Input.is_action_pressed("ui_up"):
		selectionIndex = max(selectionIndex - 1, 0)
	visualize_selection()

func visualize_selection():
	Utils.button_not_selected($HBoxContainer/VBoxContainer/MarginContainer/Selection/NewGame)
	Utils.button_not_selected($HBoxContainer/VBoxContainer/MarginContainer/Selection/Options)
	Utils.button_not_selected($HBoxContainer/VBoxContainer/MarginContainer/Selection/Exit)
	match selectionIndex:
		0: 
			Utils.button_selected($HBoxContainer/VBoxContainer/MarginContainer/Selection/NewGame)
			$HBoxContainer/VBoxContainer/MarginContainer/Selection/NewGame
		1: 
			Utils.button_selected($HBoxContainer/VBoxContainer/MarginContainer/Selection/Exit)

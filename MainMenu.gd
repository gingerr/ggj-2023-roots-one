extends MarginContainer

var selectionIndex = 0;

func _on_NewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Intro.tscn")


func _on_Exit_pressed():
	get_tree().quit()

func _ready():
	Utils.default_font_color($VBoxContainer/copyright)
	visualize_selection()

func _on_Options_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = true
	$VBoxContainer/MarginContainer/Selection.visible = false

func _on_BackToMain_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = false
	$VBoxContainer/MarginContainer/Selection.visible = true

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouse: 
		if $VBoxContainer/MarginContainer/Selection/NewGame.is_hovered():
			selectionIndex = 0;
		elif $VBoxContainer/MarginContainer/Selection/Exit.is_hovered():
			selectionIndex = 1;
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		match selectionIndex:
			0: 
				$VBoxContainer/MarginContainer/Selection/NewGame.emit_signal("pressed")
			1: 
				$VBoxContainer/MarginContainer/Selection/Exit.emit_signal("pressed")
		
	if event is InputEventKey and event.pressed and event.scancode == KEY_DOWN:
		selectionIndex = min(selectionIndex + 1, 1)
		visualize_selection()
	if event is InputEventKey and event.pressed and event.scancode == KEY_UP:
		selectionIndex = max(selectionIndex - 1, 0)
		visualize_selection()

func visualize_selection():
	Utils.button_not_selected($VBoxContainer/MarginContainer/Selection/NewGame)
	Utils.button_not_selected($VBoxContainer/MarginContainer/Selection/Options)
	Utils.button_not_selected($VBoxContainer/MarginContainer/Selection/Exit)
	match selectionIndex:
		0: 
			Utils.button_selected($VBoxContainer/MarginContainer/Selection/NewGame)
			$VBoxContainer/MarginContainer/Selection/NewGame
		1: 
			Utils.button_selected($VBoxContainer/MarginContainer/Selection/Exit)

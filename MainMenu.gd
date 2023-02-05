extends MarginContainer

var menuItems = Array([])

var selectionIndex = 0;


func _process(delta):
	if (get_tree().paused):
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = false
	else:
		$VBoxContainer/MarginContainer/Selection/Continue.disabled = true

func _on_NewGame_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Intro.tscn")


func _on_Exit_pressed():
	get_tree().quit()

func _ready():
	menuItems = Array([
		$VBoxContainer/MarginContainer/Selection/NewGame,
		$VBoxContainer/MarginContainer/Selection/Options,
		$VBoxContainer/MarginContainer/Selection/Exit,
	])
	Utils.default_font_color($VBoxContainer/copyright)
	visualize_selection()

func _on_Options_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = true
	$VBoxContainer/MarginContainer/Selection.visible = false

func _on_BackToMain_pressed():
	$VBoxContainer/MarginContainer/OptionsMenu.visible = false
	$VBoxContainer/MarginContainer/Selection.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		_on_NewGame_pressed()
	if event is InputEventKey and event.pressed and event.scancode == KEY_DOWN:
		selectionIndex = min(selectionIndex + 1, menuItems.size() - 1)
		visualize_selection()
	if event is InputEventKey and event.pressed and event.scancode == KEY_UP:
		selectionIndex = max(selectionIndex - 1, 0)
		visualize_selection()

func visualize_selection():
	print(selectionIndex)
	for i in range(menuItems.size()):
		if i == selectionIndex:
			Utils.button_selected(menuItems[selectionIndex])
		else:
			Utils.button_not_selected(menuItems[selectionIndex])
		update()

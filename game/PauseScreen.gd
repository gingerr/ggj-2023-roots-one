extends CanvasLayer

func _ready():
	Utils.default_font_color(%Label)

func _input(event: InputEvent):
	if self.visible && event.get('pressed') and event.pressed:
		get_viewport().set_input_as_handled()
		self.visible = false

func _on_visibility_changed():
	if visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		if get_parent():
			get_tree().paused = false

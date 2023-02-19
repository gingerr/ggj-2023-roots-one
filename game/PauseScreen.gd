extends CanvasLayer

func _ready():
	Utils.default_font_color(%Label)

func _input(event: InputEvent):
	if self.visible && event.get('pressed') and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().paused = false;
		self.visible = false
		get_viewport().set_input_as_handled()
	

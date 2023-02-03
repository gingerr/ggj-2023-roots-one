extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta
	var count = 0
	if (Input.is_action_pressed("ui_left")):
		move_local_x(-speed)
	if (Input.is_action_pressed("ui_up")):
		move_local_y(-speed)
	if (Input.is_action_pressed("ui_right")):
		move_local_x(speed)
	if (Input.is_action_pressed("ui_down")):
		move_local_y(speed)
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		print("Left mouse button pressed!")
	if (Input.get_mouse_button_mask() == 0x03):
		print("Left and right mouse buttons pressed!")
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	return delta

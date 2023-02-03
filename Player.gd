extends Area2D

export var muzzle_velocity = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2
	scale.x = 0.05
	scale.y = 0.05


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta
	if (Input.is_action_pressed("ui_left") && position.x > 100):
		move_local_x(-speed)
	if (Input.is_action_pressed("ui_up") && position.y > 100):
		move_local_y(-speed)
	if (Input.is_action_pressed("ui_right") && position.x < 600):
		move_local_x(speed)
	if (Input.is_action_pressed("ui_down") && position.y < 500):
		move_local_y(speed)
	if (Input.is_action_just_pressed("ui_select")):
		shoot()
		emit_signal("shoot", Bullet, rotation, position)
		print("space")
	if (Input.get_mouse_button_mask() == 0x03):
		print("Left and right mouse buttons pressed!")
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	return delta

func shoot():
	var b = Bullet.new()
	owner.add_child(b)
	b.transform = transform
	b.velocity = b.transform.x * muzzle_velocity
	b.show()

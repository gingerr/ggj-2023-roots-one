extends KinematicBody2D

signal shoot

export var muzzle_velocity = 350

onready var muzzle: Position2D = $Muzzle

var bullet_factory = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = 0.05
	scale.y = 0.05
	position.x = 100
	position.y = get_viewport_rect().size.y / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta
	if (Input.is_action_pressed("ui_left") && position.x > 100):
		move_local_y(speed)
	if (Input.is_action_pressed("ui_up") && position.y > 100):
		move_local_x(-speed)
	if (Input.is_action_pressed("ui_right") && position.x < 600):
		move_local_y(-speed)
	if (Input.is_action_pressed("ui_down") && position.y < 500):
		move_local_x(speed)
	if (Input.is_action_just_pressed("ui_select")):
		shoot()
		emit_signal("shoot", Bullet, rotation, position)
		print("shoot")
	if (Input.get_mouse_button_mask() == 0x03):
		print("Left and right mouse buttons pressed!")
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	return delta

func shoot():
	var b = bullet_factory.instance()
	
	b.global_position = muzzle.global_position
	#b.transform = transform
	get_tree().root.add_child(b)
	#b.velocity = b.transform.x * muzzle_velocity
	#b.show()

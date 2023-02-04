extends KinematicBody2D

signal shoot

export var health = 4
export var muzzle_velocity = 350

onready var muzzle: Position2D = $Muzzle

var bullet_factory = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta
	if (Input.is_action_pressed("ui_left") && position.x > 100):
		move_local_y(speed)
	if (Input.is_action_pressed("ui_up") && position.y > 100):
		move_local_x(-speed)
	if (Input.is_action_pressed("ui_right") && position.x < get_viewport_rect().size.x / 4):
		move_local_y(-speed)
	if (Input.is_action_pressed("ui_down") && position.y < get_viewport_rect().size.y - 100):
		move_local_x(speed)
	if (Input.is_action_just_pressed("ui_select")):
		shoot()
		emit_signal("shoot", Bullet, rotation, position)
	if (Input.get_mouse_button_mask() == 0x03):
		print("Left and right mouse buttons pressed!")
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	


func shoot():
	var b = bullet_factory.instance()
	b.global_position = muzzle.global_position
	get_tree().root.add_child(b)

class_name Player
extends KinematicBody2D

signal shoot

var health: int
export var muzzle_velocity: int = 350

onready var muzzle: Position2D = $Muzzle

var bullet_factory = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2
	change_health(4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta
	if (Input.is_action_pressed("ui_left") && position.x > 100):
		move_local_y(speed)
	if (Input.is_action_pressed("ui_up") && position.y > 100):
		move_local_x(-speed)
	if (Input.is_action_pressed("ui_right") && position.x < get_viewport_rect().size.x / 1):
		move_local_y(-speed)
	if (Input.is_action_pressed("ui_down") && position.y < get_viewport_rect().size.y - 100):
		move_local_x(speed)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		shoot()
		emit_signal("shoot", Bullet, rotation, position)

func shoot():
	var b = bullet_factory.instance()
	b.global_position = muzzle.global_position
	get_tree().root.add_child(b)
	
func get_health() -> int:
	return health

func change_health(value: int):
	health += value
	HUD.setHealth(health)

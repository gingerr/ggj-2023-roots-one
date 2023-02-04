class_name Player
extends KinematicBody2D

signal shoot

var health: int

export var muzzle_velocity: int = 350

onready var muzzle: Position2D = $Muzzle

const max_speed     = 300
const acceleration  = 5
var   current_speed = Vector2(0, 0)

var bullet_factory = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2
	change_health(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# accelerate and decelerate
	if Input.is_action_pressed("ui_left"):
		current_speed.x = max(-max_speed, current_speed.x - acceleration)
	if Input.is_action_pressed("ui_up"):
		current_speed.y = max(-max_speed, current_speed.y - acceleration)
	if Input.is_action_pressed("ui_right"):
		current_speed.x = min(max_speed, current_speed.x + acceleration)
	if Input.is_action_pressed("ui_down"):
		current_speed.y = min(max_speed, current_speed.y + acceleration)
	
	# bounce on scren side
	if position.x < 50:
		current_speed.x = abs(current_speed.x)
	elif position.x > get_viewport_rect().size.x - 50:
		current_speed.x = -abs(current_speed.x)
	if position.y < 50:
		current_speed.y = abs(current_speed.y)
	elif position.y > get_viewport_rect().size.y - 50:
		current_speed.y = -abs(current_speed.y)
	position += current_speed * delta;


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
	if(value > 0 && (health == 0 || health == null)):
		HUD.setMaxHealth(value)
	
	health += value
	HUD.setHealth(health)
	if health == 0:
		queue_free()
		
	

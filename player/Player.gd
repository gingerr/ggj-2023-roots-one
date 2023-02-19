class_name Player
extends CharacterBody2D

signal shoot
signal dead
signal health_changed(value: int)
signal max_health_changed(value: int)
signal shield_changed(value: float)

var health: int

@export var muzzle_velocity: int = 350

@onready var muzzle: Marker2D = $Muzzle

const max_speed     = 300
const acceleration  = 1000
var   current_speed = Vector2(0, 0)

var bullet_factory = preload("res://player/Bullet.tscn")
var explosionPreload = preload("res://game/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2
	change_health(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (health <= 0):
		return
	
	hideThrusters()
	
	# accelerate and decelerate
	if Input.is_action_pressed("ui_left"):
		current_speed.x = max(-max_speed, current_speed.x - acceleration * delta)
		$thrust_front_left.visible = true 
		$thrust_front_right.visible = true 
		if !$ThrusterSoundFront.playing:
			$ThrusterSoundFront.play()
	else:
		$ThrusterSoundFront.stop()
		
	if Input.is_action_pressed("ui_up"):
		current_speed.y = max(-max_speed, current_speed.y - acceleration * delta)
		$thrust_right.visible = true
		if !$ThrusterSoundRight.playing:
			$ThrusterSoundRight.play()
	else:
		$ThrusterSoundRight.stop()
		
	if Input.is_action_pressed("ui_right"):
		current_speed.x = min(max_speed, current_speed.x + acceleration * delta)
		$thrust_back_left.visible = true 
		$thrust_back_right.visible = true 
		if !$ThrusterSoundBack.playing:
			$ThrusterSoundBack.play()
	else:
		$ThrusterSoundBack.stop()
		
	if Input.is_action_pressed("ui_down"):
		current_speed.y = min(max_speed, current_speed.y + acceleration * delta)
		$thrust_left.visible = true
		if !$ThrusterSoundLeft.playing:
			$ThrusterSoundLeft.play()
	else:
		$ThrusterSoundLeft.stop()
		
	
	# bounce checked scren side
	if position.x < 50:
		current_speed.x = abs(current_speed.x / 2)
	elif position.x > get_viewport_rect().size.x - 50:
		current_speed.x = -abs(current_speed.x / 2)
	if position.y < 50:
		current_speed.y = abs(current_speed.y / 2)
	elif position.y > get_viewport_rect().size.y - 50:
		current_speed.y = -abs(current_speed.y / 2)
	position += current_speed * delta;
	

func _input(event: InputEvent) -> void:
	if (health <= 0):
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		action_shoot()
		emit_signal("shoot", Bullet, rotation, position)

func action_shoot():
	var b = bullet_factory.instantiate()
	b.global_position = muzzle.global_position
	get_tree().root.add_child(b)
	
func change_health(value: int):
	if(value > 0 && (health == 0 || health == null)):
		max_health_changed.emit(value)
	
	health += value
	health_changed.emit(health)

	if health == 0:
		explode()
		visible = false
		
func explode():
	hideThrusters()
	emit_signal('dead')
	var explosion = explosionPreload.instantiate()
	explosion.global_position = self.global_position
	explosion.scale = Vector2(5, 5)
	explosion.lifetime = 4
	explosion.speed_scale = 0.5
	get_tree().root.add_child(explosion)
	
func hideThrusters():
	$thrust_left.visible = false
	$thrust_right.visible = false
	$thrust_back_left.visible = false 
	$thrust_back_right.visible = false 
	$thrust_front_left.visible = false 
	$thrust_front_right.visible = false 
	
func _on_shield_area_shield_changed(value: float):
	shield_changed.emit(value)

class_name Bullet 
extends Area2D

var velocity = Vector2(1000, 0)

func _ready():
	position.x = 100
	position.y = get_viewport_rect().size.y / 2
	scale.x = 0.01
	scale.y = 0.01

func _physics_process(delta):
	position += velocity * delta

func _process(delta):
	position += velocity * delta
	rotation = velocity.angle()


func _on_BallisticBullet_body_entered(body):
	queue_free()

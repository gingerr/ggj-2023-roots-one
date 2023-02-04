extends Area2D

var spin_speed     = 0.3
var spin_direction = 1
var velocity       = Vector2(-20, 0)

func _ready():
	position.y = rand_range(50,get_viewport_rect().size.y - 50)
	randomize()
	spin_direction = pow(-1, randi() % 2)

func _process(delta):
	position += velocity * delta
	rotate(spin_speed * delta * spin_direction)


func set_text(value: String):
	$Label.text = value
	
func explode():
	print('boom')

func _on_area_entered(area):
	if (area is Bullet): 
		queue_free();
		area.queue_free()
		explode()
	

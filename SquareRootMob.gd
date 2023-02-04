extends Area2D

var spin_direction = 1
var velocity       = Vector2(-20, 0)

func _ready():
	position.y = rand_range(50,get_viewport_rect().size.y - 50)
	randomize()
	if int(rand_range(1, 3)) == 1:
		spin_direction *= -1

func _process(delta):
	position += velocity * delta
	rotate(0.3 * delta * spin_direction)


func set_text(value: String):
	$Label.text = value
	
func explode():
	print('boom')


func _on_area_entered(area):
	if (area is Bullet): 
		queue_free();
		area.queue_free()
		explode()
	

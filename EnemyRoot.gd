extends Area2D

var spin_speed     = 0.3
var spin_direction = 1
var velocity       = Vector2(-20, 0)

func _ready():
	# position
	var x = get_viewport_rect().size.x
	var y = rand_range(50,get_viewport_rect().size.y - 50)
	position = Vector2(x, y)

	randomize()
	spin_direction = pow(-1, randi() % 2)

func configure(difficulty_level):

	# difficulty
	var enemy_difficulty = randi() % difficulty_level + 1
	print(enemy_difficulty)
	var enemy_is_good = Utils.randomBoolean();
	if enemy_is_good:
		enemy_difficulty = int(sqrt(enemy_difficulty));
		enemy_difficulty = pow(enemy_difficulty, 2);
	else:
		if is_enemy_good(enemy_difficulty) == false:
			enemy_difficulty +=1
	print(enemy_is_good)
	print(enemy_difficulty)
	print()
	set_text(str(enemy_difficulty))


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

func is_enemy_good(difficulty):
	if int(sqrt(difficulty)) == sqrt(difficulty):
		return true	
	return false

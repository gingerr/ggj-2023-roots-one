extends Area2D

var spin_speed     = 0.3
var spin_direction = 1
var velocity       = Vector2(-60, 0)
var difficulty     = 0

func _ready():
	# position
	var x = get_viewport_rect().size.x + 100
	var y = rand_range(50,get_viewport_rect().size.y - 50)
	position = Vector2(x, y)

	# spin
	randomize()
	spin_direction = pow(-1, randi() % 2)
	
	# speed
	var boostSpeed = randf() + 1
	velocity *= boostSpeed
	

func configure(difficulty_level):
	# difficulty
	var enemy_difficulty = randi() % difficulty_level + 1
	var enemy_is_good = Utils.randomBoolean();
	if enemy_is_good:
		enemy_difficulty = int(sqrt(enemy_difficulty));
		enemy_difficulty = pow(enemy_difficulty, 2);
	else:
		if is_enemy_good() == false:
			enemy_difficulty +=1
	difficulty = enemy_difficulty;
	set_text(str(difficulty))
	print(is_enemy_good())
	print(randi() %2)


func _process(delta):
	position += velocity * delta
	rotate(spin_speed * delta * spin_direction)


func set_text(value: String):
	$Label.text = value
	
func explode():
	queue_free();
	print('boom')

func _on_area_entered(area):
	if (area is Bullet): 
		area.queue_free()
		explode()
		if is_enemy_good():
			print("Reduce Player Health")
			get_node("/root/Game/Player").change_health(-1)
		else:
			HUD.increaseScore(1)

func is_enemy_good():
	if int(sqrt(difficulty)) == sqrt(difficulty):
		return true	
	return false


func _on_player_colission(body: Node):
	# hit player and despawn
	if (body is Player):
		explode()
		print("Reduce Player Health")
		body.change_health(-1)
	# despawn on left screen side
	if body.get_name() == "DeathZone":
		explode()
		if !is_enemy_good():
			print("Reduce Player Health")
		else:
			HUD.increaseScore(1)

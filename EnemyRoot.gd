class_name EnemyRoot
extends Area2D

var spin_speed     = 0.3
var spin_direction = 1

var velocity       = Vector2(-50, 0)
var difficulty     = 0

func _ready():
	# position
	var x = get_viewport_rect().size.x + 50
	var y = rand_range(50,get_viewport_rect().size.y - 50)
	position = Vector2(x, y)

	# spin
	randomize()
	spin_speed = randf();
	spin_direction = pow(-1, randi() % 2)
	
	# speed
	# the bigger the screen, the fast to horizontal speed
	velocity.x = -get_viewport_rect().size.x / 30
	velocity.y = rand_range(0, velocity.x /3) * pow(-1, randi() % 2)
	
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

func _process(delta):
	# calulate new position
	position += velocity * delta
	if (position.y - 50 < HUD.topHeight):
		velocity.y = abs(velocity.y)
	elif position.y + 50 > get_viewport_rect().size.y - HUD.bottomHeight:
		velocity.y = -abs(velocity.y)
	if position.x < -50 && is_enemy_good():
		queue_free()
	
	rotate(spin_speed * delta * spin_direction)


func set_text(value: String):
	$Label.text = value
	
func explode():
	queue_free();

func is_enemy_good():
	if int(sqrt(difficulty)) == sqrt(difficulty):
		return true	
	return false

func _on_area_entered(area : Area2D):
	if (area is Bullet): 
		area.queue_free()
		explode()
		if is_enemy_good():
			get_node("/root/Game/Player").change_health(-1)
		else:
			HUD.increaseScore(1)
	elif "EnemyRoot" in area.get_name():
		collide(area, self)
			
func _on_player_colission(body: Node):
	# hit player and despawn
	if (body is Player):
		$CrashSound.play(0.0)	
		explode()
		body.change_health(-1)
		body.current_speed.x = -body.current_speed.x / 2
		body.current_speed.y = -body.current_speed.y / 2
		
	# despawn on left screen side
	if "DeathZone" in body.get_name():
		if !is_enemy_good():
			explode()
			get_node("/root/Game/Player").change_health(-1)
		else:
			HUD.increaseScore(1)
			
func collide(a, b):
	var xDist = a.position.x - b.position.x
	var yDist = a.position.y - b.position.y
	var distSquared = xDist * xDist + yDist * yDist
	
	var speedXocity = b.velocity.x - a.velocity.x
	var speedYocity = b.velocity.y - a.velocity.y
	var dotProduct = xDist * speedXocity + yDist * speedYocity;
	# vector maths, used for checking if the objects moves towards
	# one another.
	if dotProduct > 0:
		var collisionScale = dotProduct / distSquared;
		var xCollision = xDist * collisionScale;
		var yCollision = yDist * collisionScale;
		# The Collision vector is the speed difference projected on the
		# Dist vector,
		# thus it is the component of the speed difference needed for
		# the collision.

		# simplified for mass.. so far both 1 
		var massA = 1
		var massB = 1;
		var combinedMass = massA + massB;
		var collisionWeightA = 2 * massB / combinedMass;
		var collisionWeightB = 2 * massA / combinedMass;
		a.velocity.x += (collisionWeightA * xCollision);
		a.velocity.y += (collisionWeightA * yCollision);
		b.velocity.x -= (collisionWeightB * xCollision);
		b.velocity.y -= (collisionWeightB * yCollision);

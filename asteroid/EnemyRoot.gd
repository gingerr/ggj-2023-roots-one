class_name EnemyRoot
extends Area2D

signal scored
signal wrong_hit

const explosionPreload = preload("res://game/Explosion.tscn")
const hintPreload = preload("res://asteroid/Hint.tscn")

@export var safeZoneTop: int
@export var safeZoneBottom: int

var textures_asteroid = Array ([
	preload("res://asteroid/res/asteroid1.png"), 
	preload("res://asteroid/res/asteroid2.png"),
	preload("res://asteroid/res/asteroid3.png"),
	preload("res://asteroid/res/asteroid4.png"),
	preload("res://asteroid/res/asteroid5.png"),
	preload("res://asteroid/res/asteroid6.png"),
	preload("res://asteroid/res/asteroid7.png"),
	])
var spin_speed     = 0.3
var spin_direction = 1

var velocity       = Vector2(0, 0)
var difficulty     = 0

func _ready():
	# init preloaded textures
	randomize()
	var rand_index:int = randi() % textures_asteroid.size()
	$AsteroidSprite.texture = textures_asteroid[rand_index]
	
	# position
	var x = get_viewport_rect().size.x + 50
	var y = randf_range(50,get_viewport_rect().size.y - 50)
	position = Vector2(x, y)

	# spin
	randomize()
	spin_speed = randf();
	spin_direction = pow(-1, randi() % 2)
	
	# speed
	# the bigger the screen, the fast to horizontal speed
	velocity.x = -get_viewport_rect().size.x / 25
	velocity.y = randf_range(0, velocity.x /3) * pow(-1, randi() % 2)
	
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
	if (position.y - 50 < safeZoneTop):
		velocity.y = abs(velocity.y)
	elif position.y + 50 > get_viewport_rect().size.y - safeZoneBottom:
		velocity.y = -abs(velocity.y)
	if position.x < -50 && is_enemy_good():
		queue_free()
	elif (position.x > get_viewport_rect().size.x):
		velocity.x = -abs(velocity.x)

	
	rotate(spin_speed * delta * spin_direction)


func set_text(value: String):
	$Label.text = value


func explode():
	var explosion = explosionPreload.instantiate()
	explosion.global_position = self.global_position
	get_parent().add_child(explosion)
	
	if is_enemy_good():
		var hint = hintPreload.instantiate()
		hint.position = self.global_position
		hint.position.x -= 30   
		hint.set_text("= " + str(sqrt(difficulty)))
		get_parent().add_child(hint)
		$CollisionPolygon2D.free()
		visible = false
		$WrongHit.play(0)
		await $WrongHit.finished
		queue_free()
	else:
		queue_free()

func is_enemy_good():
	if int(sqrt(difficulty)) == sqrt(difficulty):
		return true	
	return false

func _on_area_entered(area : Area2D):
	if (area is Bullet): 
		area.queue_free()
		explode()
		if is_enemy_good():
			wrong_hit.emit()
		else:
			scored.emit()
		get_viewport().set_input_as_handled()
	elif "EnemyRoot" in area.get_name():
		collide(area, self)
		get_viewport().set_input_as_handled()
			
func _on_body_entered(body: Node):
	# hit player and despawn
	if (body is Player):
		explode()
		body.change_health(-1)
		body.current_speed.x = -body.current_speed.x / 2
		body.current_speed.y = -body.current_speed.y / 2
		
	# despawn checked left screen side
	if "DeathZone" in body.get_name():
		if !is_enemy_good():
			wrong_hit.emit()
			explode()
		else:
			scored.emit()
			
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
		# The Collision vector is the speed difference projected checked the
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

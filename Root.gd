extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport_rect().size.x - 100
	position.y = get_viewport_rect().size.y / 2
	scale.x = 0.1
	scale.y = 0.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 500 * delta

	return delta

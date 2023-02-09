extends Node

# Game Scene
const squareRootFactory = preload("res://EnemyRoot.tscn")

func _ready():
	# This is a performance workaround for the issue, that first spawn in-game of asterooid was slow
	var dummy = squareRootFactory.instance();
	add_child(dummy)
	call_deferred("remove_child", dummy)

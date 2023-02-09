class_name BoomBox
extends Node2D

static func playExplosionAt(position: Vector2, parent):
	var factory = load("res://BoomBox.tscn")
	var player = factory.instance()
	player._playExplosionAt(position)
	parent.root.add_child(player)

func _playExplosionAt(position: Vector2):
	$ExplosionSound.global_position = position
	$ExplosionSound.play(0.1)
	

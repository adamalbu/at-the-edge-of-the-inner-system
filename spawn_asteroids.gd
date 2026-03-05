extends Node

@export
var spawn_path_follow: PathFollow2D

@export
var asteroid_scene: PackedScene

@export
var player: Sprite2D;

@onready
var spawn_timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.connect("timeout", _on_timer_timeout)
	spawn_asteroid()

func _on_timer_timeout():
	spawn_asteroid()

func spawn_asteroid():
	spawn_path_follow.progress_ratio = randf()
	var asteroid = asteroid_scene.instantiate()
	asteroid.position = spawn_path_follow.global_position
	asteroid.player = player

	self.add_child(asteroid)

extends Node

@export
var spawn_path_follow: PathFollow2D
@export
var asteroid_scene: PackedScene
@export
var player: Sprite2D
@export
var camera: Node2D

@onready
var spawn_timer = $SpawnTimer
@onready
var spawn_path = $SpawnPath

var noise = FastNoiseLite.new()

func _ready() -> void:
	noise.seed = 5
	noise.frequency = 0.005

	spawn_timer.connect("timeout", _on_timer_timeout)
	spawn_asteroid()

func _on_timer_timeout():
	spawn_asteroid()

func spawn_asteroid():
	spawn_path.position = camera.global_position

	spawn_path_follow.progress_ratio = randf()
	var asteroid = asteroid_scene.instantiate()
	asteroid.global_position = spawn_path_follow.global_position
	asteroid.player = player

	self.add_child(asteroid)

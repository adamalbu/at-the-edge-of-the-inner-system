extends Node

const CHUNK_SIZE = 1000
const VIEW_DISTANCE = 3
const MAX_ASTEROIDS_PER_CHUNK = 20
const SAMPLE_SPACE = 180
const SPAWN_THRESHOLD = 0.4

@export
var asteroid_scene: PackedScene
@export
var player: RigidBody2D

var noise = FastNoiseLite.new()

var loaded_chunks: Dictionary = {}

func _ready():
	noise.seed = 621
	noise.frequency = 0.0005

func _process(_delta):
	update_chunks()

func get_player_cunk():
	var pos = player.global_position
	var chunk_pos = Vector2i (
		floor(pos.x / CHUNK_SIZE),
		floor(pos.y / CHUNK_SIZE),
	)
	return chunk_pos

func update_chunks():
	var player_cunk = get_player_cunk()

	var needed_chunks = {}

	for x in range(-VIEW_DISTANCE, VIEW_DISTANCE + 1):
		for y in range(-VIEW_DISTANCE, VIEW_DISTANCE + 1):
			var chunk = player_cunk + Vector2i(x, y)
			needed_chunks[chunk] = true

			if chunk not in loaded_chunks:
				spawn_chunk(chunk)

	for chunk in loaded_chunks.keys():
		if chunk not in needed_chunks:
			despawn_chunk(chunk)

func spawn_chunk(chunk):
	var asteroids = []
	var base = Vector2(chunk.x * CHUNK_SIZE, chunk.y * CHUNK_SIZE)

	for x in range(0, CHUNK_SIZE, SAMPLE_SPACE):
		for y in range(0, CHUNK_SIZE, SAMPLE_SPACE):
			var value = noise.get_noise_2d(base.x + x, base.y + y)

			if value >= SPAWN_THRESHOLD :
				var asteroid: RigidBody2D = asteroid_scene.instantiate()

				asteroid.position = Vector2(base.x + x + randf_range(-50, 50), base.y + y + randf_range(-50, 50))

				add_child(asteroid)
				asteroids.append(asteroid)

	loaded_chunks[chunk] = asteroids

func despawn_chunk(chunk):
	for asteroid in loaded_chunks[chunk]:
		if is_instance_valid(asteroid):
			asteroid.queue_free()

	loaded_chunks.erase(chunk)

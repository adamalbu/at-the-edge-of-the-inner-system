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

var destroyed_asteroids: Dictionary = {}

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

			if value >= SPAWN_THRESHOLD:
				var world_pos = Vector2i(base.x + x, base.y + y)
				# TODO: Better way to do this
				if world_pos in destroyed_asteroids:
					continue

				var asteroid: RigidBody2D = asteroid_scene.instantiate()

				asteroid.position = Vector2(world_pos.x + randf_range(-50, 50), world_pos.y + randf_range(-50, 50))
				asteroid.id = Vector2i(world_pos)
				asteroid.linear_velocity = Vector2(randf_range(-15, 15), randf_range(-15, 15))
				asteroid.connect("destroyed", _on_asteroid_destroyed)

				add_child(asteroid)
				asteroids.append(asteroid)

	loaded_chunks[chunk] = asteroids

func despawn_chunk(chunk):
	for asteroid in loaded_chunks[chunk]:
		if is_instance_valid(asteroid):
			asteroid.queue_free()

	loaded_chunks.erase(chunk)

func _on_asteroid_destroyed(asteroid):
	destroyed_asteroids[asteroid.id] = true
	for chunk in loaded_chunks:
		var list = loaded_chunks[chunk]
		var i = list.find(asteroid)
		if i != -1:
			list.remove_at(i)
			break
	GameState.money += 10

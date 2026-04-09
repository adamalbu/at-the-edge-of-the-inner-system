extends RayCast2D

@export
var lasers: Array[Node2D]

var draw_lasers = false

@onready var mine_particles = $MineParticles
@onready var laser_particles = $LaserParticles
@onready var laser_light = $LaserLight
@onready var ship_laser_lights = [$LaserPosLeft/LaserLightLeft, $LaserPosRight/LaserLightLeft]

func _draw() -> void:
	if draw_lasers:
		for laser in lasers:
			var origin = to_local(laser.global_position)
			var hit = to_local(get_collision_point())
			draw_line(origin, hit, Color.GREEN, 1.0)

func _process(delta: float) -> void:
	queue_redraw()

	if Input.is_action_pressed("fire") and self.is_colliding() && get_viewport_rect().has_point(get_viewport().canvas_transform * self.get_collision_point()):
		var object: Node2D = get_collider()
		if object is Object and object.is_in_group("asteroid"):
			draw_lasers = true

			var hit_point = get_collision_point()

			mine_particles.global_position = hit_point
			mine_particles.emitting = true
			laser_particles.global_position = hit_point
			laser_particles.emitting = true

			laser_light.global_position = hit_point
			laser_light.visible = true

			for light in ship_laser_lights:
				light.visible = true

			var asteroid = get_collider()
			asteroid.health -= 10 * delta
			asteroid.damaged_by_player = true
	else:
		draw_lasers = false
		
		for light in ship_laser_lights:
			light.visible = false
		mine_particles.emitting = false
		laser_particles.emitting = false
		laser_light.visible = false

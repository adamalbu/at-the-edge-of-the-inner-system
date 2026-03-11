extends RayCast2D

@export
var lasers: Array[Node2D]

func _draw() -> void:
	if Input.is_action_pressed("fire") and self.is_colliding() && get_viewport_rect().has_point(get_viewport().canvas_transform * self.get_collision_point()):
	# if Input.is_action_pressed("fire"):
		for laser in lasers:
			var origin = to_local(laser.global_position)
			var hit = to_local(self.get_collision_point())
			draw_line(origin, hit, Color.GREEN, 1.0)

func _process(_delta: float) -> void:
	queue_redraw()

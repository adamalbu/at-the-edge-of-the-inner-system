extends Node2D

func _ready() -> void:
	visible = false
	for child: RigidBody2D in get_children():
		child.freeze = true
		child.visible = false
		var collider = child.get_child(-1)
		collider.set_deferred("disabled", true)

func show_fragments(linear_velocity: Vector2, angular_velocity: float) -> void:
	visible = true
	for child: RigidBody2D in get_children():
		child.freeze = false
		child.visible = true
		child.linear_velocity = linear_velocity + Vector2(randf() * 10, randf() * 10)
		child.angular_velocity = angular_velocity + randf() * 10
		
		var collider = child.get_child(-1)
		collider.set_deferred("disabled", false)

func get_average_pos() -> Vector2:
	var total: Vector2
	for child: RigidBody2D in get_children():
		total += child.position
	
	return total / get_child_count()

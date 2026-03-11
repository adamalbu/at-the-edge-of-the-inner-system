extends RigidBody2D

const THRUST = 40000.0
const TORQUE = 700000.0

func _physics_process(_delta: float) -> void:
	var thrust = 0.0
	if Input.is_action_pressed("forward"):
		thrust -= THRUST
	if Input.is_action_pressed("backwards"):
		thrust += THRUST

	if thrust != 0.0:
		apply_force(Vector2(0, thrust).rotated(rotation))

	var torque = 0.0
	if Input.is_action_pressed("left"):
		torque -= TORQUE
	if Input.is_action_pressed("right"):
		torque += TORQUE

	apply_torque(torque)

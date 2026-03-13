extends RigidBody2D

const THRUST = 40000.0
const TORQUE = 700000.0

@export var max_health = 100.0
var health = max_health

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

func _integrate_forces(state: PhysicsDirectBodyState2D):
	for i in state.get_contact_count():
		var impulse = state.get_contact_impulse(i).length()

		if impulse > 700:

			var lost_health = impulse * 0.0003

			health -= lost_health

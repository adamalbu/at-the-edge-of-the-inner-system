extends RigidBody2D

@export var max_health = 100.0
var health = max_health

var max_size = 0.0

signal destroyed(asteroid)

func _ready():
	max_size = $Control/HealthBg.size.x

func _process(_delta: float):
	if health != max_health:
		$Control.visible = true
		$Control/HealthFg.size.x = (health / max_health) * max_size

	if health <= 0:
		destroy()

func _integrate_forces(state: PhysicsDirectBodyState2D):
	for i in state.get_contact_count():
		var impulse = state.get_contact_impulse(i).length()

		if impulse > 700:

			var lost_health = impulse * 0.0001

			health -= lost_health

func destroy():
	destroyed.emit(self)
	queue_free()

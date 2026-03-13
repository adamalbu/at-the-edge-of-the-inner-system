extends RigidBody2D

@export var max_health = 100.0
var health = max_health

var max_size = 0.0

func _ready():
	max_size = $Control/HealthBg.size.x

func _process(_delta: float):
	if health != max_health:
		$Control.visible = true
		$Control/HealthFg.size.x = (health / max_health) * max_size

	if health <= 0:
		queue_free()

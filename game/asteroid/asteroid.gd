extends RigidBody2D

@export var max_health = 100.0
var health = max_health

var max_size = 0.0
var destroying = false

@onready var control = $Control

var id: Vector2i
var damaged_by_player: bool

signal destroyed(asteroid)

func _ready():
	max_size = $Control/HealthBg.size.x

	$Sprite2D.rotation_degrees = randf_range(0, 360)

func _process(_delta: float):
	control.rotation = -rotation
	control.global_position = global_position - Vector2(control.size.x / 2, -70)

	if damaged_by_player && !destroying:
		$Control.visible = true
		$Control/HealthFg.size.x = (health / max_health) * max_size

	if health <= 0 && !destroying:
		destroy()

func _integrate_forces(state: PhysicsDirectBodyState2D):
	for i in state.get_contact_count():
		var impulse = state.get_contact_impulse(i).length()

		if !damaged_by_player:
			for body in get_colliding_bodies():
				if body.is_in_group("player"):
					damaged_by_player = true

		if impulse > 700:

			var lost_health = impulse * 0.0001

			health -= lost_health

func destroy():
	destroying = true
	destroyed.emit(self)
	GameState.run_money += 10
	$AnimationPlayer.play("asteroid_delete")

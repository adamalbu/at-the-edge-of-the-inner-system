extends Node

var destroyed_asteroids: Dictionary = {}

enum DrillType {SUSTAINED, BURST}

var upgrades: Dictionary[String, int] = {}

var money: int = 150
var run_money: int = 0

var drill_type = DrillType.SUSTAINED

const BASE_THRUST= 40000.0
const BASE_TORQUE = 700000.0

var thrust = BASE_THRUST
var torque = BASE_TORQUE

const BASE_ANGULAR_DAMPENING = 0.0
const BASE_LINEAR_DAMPENING = 0.0

var angular_damp = BASE_ANGULAR_DAMPENING
var linear_damp = BASE_LINEAR_DAMPENING

const BASE_RANGE = 200.0
const BASE_DAMAGE = 10.0

var range = BASE_RANGE
var damage = BASE_DAMAGE

func upgrade(upgrade_name: String) -> void:
	if upgrades.has(upgrade_name):
		upgrades[upgrade_name] += 1
	else:
		upgrades[upgrade_name] = 1

	update_upgrade(upgrade_name)

func get_upgrade_level(upgrade_name: String) -> int:
	if upgrades.has(upgrade_name):
		return upgrades[upgrade_name]
	else:
		return 0

func update_upgrades() -> void:
	for upgrade_name in upgrades:
		update_upgrade(upgrade_name)

func update_upgrade(upgrade_name: String) -> void:
	match upgrade_name:
		"Burst":
			drill_type = DrillType.BURST
		"Sustained":
			drill_type = DrillType.SUSTAINED
		"Thrust":
			thrust = BASE_THRUST * (1 + upgrades["Thrust"] * 0.3) * (1 + get_upgrade_level("Stabilizers") * 0.6)
		"Torque":
			torque = BASE_TORQUE * (1 + upgrades["Torque"]) * (1 + get_upgrade_level("Gyroscope") * 0.4)
		"Gyroscope":
			angular_damp = BASE_ANGULAR_DAMPENING + 0.5 * upgrades["Gyroscope"]
		"Stabilizers":
			linear_damp = BASE_LINEAR_DAMPENING + 0.5 * upgrades["Stabilizers"]
		"Drill":
			range = BASE_RANGE + 30
			damage = BASE_DAMAGE + 20
		"Range":
			range = BASE_RANGE + 30 + (20 * upgrades["Range"])
		"Damage":
			damage = BASE_DAMAGE + 20 + (10 * upgrades["Damage"])

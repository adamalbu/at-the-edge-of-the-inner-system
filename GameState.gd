extends Node

enum DrillType {SUSTAINED, BURST}

var upgrades: Dictionary[String, int] = {}

var money: int = 400
var run_money: int = 0

var drill_type = DrillType.SUSTAINED

const BASE_THRUST= 40000.0
const BASE_TORQUE = 700000.0

var thrust = 40000.0
var torque = 700000.0

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
			thrust = BASE_THRUST * (1 + upgrades["Thrust"] * 0.1)
		"Torque":
			torque = BASE_TORQUE * (1 + upgrades["Torque"] * 1)
			print(upgrades["Torque"])

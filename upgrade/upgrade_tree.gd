class_name UpgradeTree
extends Control

@export var side_panel: SidePanel
@export var animation_player: AnimationPlayer

func upgrade_unlocked(name: String) -> void:
	match name:
		"Burst":
			GameState.drill_type = GameState.DrillType.BURST
		"Sustained":
			GameState.drill_type = GameState.DrillType.SUSTAINED

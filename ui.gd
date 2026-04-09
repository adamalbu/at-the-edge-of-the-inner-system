extends Control

@onready var money_label = $Label

func _process(_delta: float) -> void:
	money_label.text = "₡" + str(GameState.run_money)
	pass

@tool
extends "res://upgrade/upgrade_button.gd"

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.name = self.title
		self.text = self.title
		$Price.text = "₡" + str(self.price)
	else:
		if exclude_if.bought:
			self.disabled = true

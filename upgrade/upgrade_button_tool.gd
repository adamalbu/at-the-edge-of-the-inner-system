@tool
extends "res://upgrade/upgrade_button.gd"

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.name = self.title
		self.text = self.title
		$Price.text = "₡" + str(self.price)
	else:
		if self.exclude_if != null and self.exclude_if.bought:
			self.disabled = true
			
		if self.dependency != null and self.dependency.bought:
			self.visible = true

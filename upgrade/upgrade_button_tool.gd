@tool
extends "res://upgrade/upgrade_button.gd"


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.text = self.title

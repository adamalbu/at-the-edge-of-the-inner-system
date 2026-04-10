@tool
extends "res://upgrade/upgrade_button.gd"



func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.update_button()
		
	else:
		if self.exclude_if != null and self.exclude_if.is_maxed():
			self.disabled = true
			
		if self.dependency != null and self.dependency.is_maxed():
			self.visible = true
	
	$Level.text = str(self.level) + "/" + str(self.max_level)

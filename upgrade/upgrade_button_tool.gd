@tool
extends "res://upgrade/upgrade_button.gd"

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_refresh()
		return

	if exclude_if != null and exclude_if.is_maxed():
		disabled = true

	if dependency != null and dependency.level >= dependency_min_level:
		visible = true

	$Level.text = "%d/%d" % [level, current_max_level]

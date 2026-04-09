extends Control

@onready var timer: Timer = $Timer
@onready var clip: Control = $ColorRect

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		timer.start()
	if Input.is_action_just_released("action"):
		timer.stop()
	
	if Input.is_action_pressed("action"):
		clip.anchor_right = 1.0 - timer.time_left / timer.wait_time
	else:
		clip.anchor_right = 0.0


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://upgrade/upgrade_ui.tscn")

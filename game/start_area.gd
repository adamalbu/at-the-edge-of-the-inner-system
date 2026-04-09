extends Area2D

@export var end_run_label: Control


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		self.end_run_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		self.end_run_label.visible = false

extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(1920.0, 0.0), 1)
	tween.parallel().tween_property(self, "size", Vector2(0, 1080), 1)

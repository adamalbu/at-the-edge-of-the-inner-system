extends ColorRect

const TWEEN_TIME = 0.5

func _ready() -> void:
	visible = true
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(1920.0, 0.0), TWEEN_TIME)
	tween.parallel().tween_property(self, "size", Vector2(0, 1080), TWEEN_TIME)

func slide_in() -> void:
	size = Vector2(0.0, 1080.0)
	position = Vector2(0.0, 0.0)
	
	visible = true
	
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "size", Vector2(1920, 1080), TWEEN_TIME)
	
	await tween.finished

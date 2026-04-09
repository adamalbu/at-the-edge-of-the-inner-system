class_name SidePanel
extends Panel

func _ready() -> void:
	self.hide_text()

func set_title(title: String) -> void:
	$TextMargin/Texts/Title.text = title

func set_description(description: String) -> void:
	$TextMargin/Texts/Description.text = description

func hide_text() -> void:
	$AnimationPlayer.stop()
	$BackgroundMargin.visible = false
	$TextMargin.visible = false
	
func show_text() -> void:
	$AnimationPlayer.play("text_in")
	$BackgroundMargin.visible = true
	$TextMargin.visible = true

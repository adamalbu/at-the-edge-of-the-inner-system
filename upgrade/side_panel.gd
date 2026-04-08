class_name SidePanel
extends Panel

func _ready() -> void:
	self.hide_text()

func set_title(title: String) -> void:
	$TextMargin/Texts/Title.text = title

func set_description(description: String) -> void:
	$TextMargin/Texts/Description.text = description

func hide_text() -> void:
	$BackgroundMargin.visible = false
	$TextMargin.visible = false
	
func show_text() -> void:
	$BackgroundMargin.visible = true
	$TextMargin.visible = true

class_name UpgradeButton
extends Button

@export var title: String = "..."
@export_multiline var description: String = ""
@export var price: int = 0
@export var side_panel: SidePanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = self.title
	$Price.text = "₡" + str(self.price)

func _on_mouse_entered() -> void:
	self.side_panel.show_text()
	self.side_panel.set_title(self.title)
	self.side_panel.set_description(self.description)

func _on_mouse_exited() -> void:
	self.side_panel.hide_text()

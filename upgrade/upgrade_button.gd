class_name UpgradeButton
extends Button

@export_category("Basic Info")
@export var title: String = "..."
@export_multiline var description: String = ""
@export var price: int = 0

@export_category("Dependencies")
@export var exclude_if: UpgradeButton

var bought = false

const tree_parent_name: String = "UpgradeTree"

var tree_parent: UpgradeTree

func _ready() -> void:
	self.text = self.title
	$Price.text = "₡" + str(self.price)
	self.tree_parent = self.find_parent(tree_parent_name)

func _on_mouse_entered() -> void:
	self.tree_parent.side_panel.show_text()
	self.tree_parent.side_panel.set_title(self.title)
	self.tree_parent.side_panel.set_description(self.description)

func _on_mouse_exited() -> void:
	self.tree_parent.side_panel.hide_text()

func _on_pressed() -> void:
	self.tree_parent.animation_player.stop()
	if self.price > GameState.money:
		self.tree_parent.animation_player.play("not_enough")
	else:
		GameState.money -= self.price
		self.bought = true
		self.disabled = true

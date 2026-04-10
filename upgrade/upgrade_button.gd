class_name UpgradeButton
extends Button

@export_category("Basic Info")
@export var title: String = "..."
@export_multiline var description: String = ""
@export var price: int = 0

@export var max_level: int = 1
@export var price_multiplier: float = 2.0

@export_category("Dependencies")
@export var exclude_if: UpgradeButton
@export var dependency: UpgradeButton
@export var dependency_min_level: int = 1

var level = 0

const tree_parent_name: String = "UpgradeTree"

var tree_parent: UpgradeTree

func update_button() -> void:
	self.name = self.title
	self.text = self.title
	$Price.text = "₡" + str(self.price)

	self.tree_parent = self.find_parent(tree_parent_name)

	if self.max_level <= 1:
		$Level.visible = false
	else:
		$Level.visible = true

func is_maxed() -> bool:
	return self.max_level == self.level

func _ready() -> void:
	self.update_button()

	self.level = GameState.get_upgrade_level(self.title)

	if self.dependency != null:
		self.visible = false

func _on_mouse_entered() -> void:
	if self.disabled:
		return

	self.tree_parent.side_panel.show_text()
	self.tree_parent.side_panel.set_title(self.title)
	self.tree_parent.side_panel.set_description(self.description)

func _on_mouse_exited() -> void:
	self.tree_parent.side_panel.hide_text()

func _on_pressed() -> void:
	if self.price > GameState.money:
		self.tree_parent.animation_player.stop()
		self.tree_parent.animation_player.play("not_enough")
	else:
		self.level += 1
		GameState.money -= self.price

		if self.is_maxed():
			self.disabled = true

		GameState.upgrade(self.title)

		self.price = round(self.price * self.price_multiplier)
		self.update_button()

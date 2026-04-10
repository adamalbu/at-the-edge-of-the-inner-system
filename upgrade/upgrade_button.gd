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
@export var inherit_max_level: bool = false

var current_max_level: int = 1
var level: int = 0
var tree_parent: UpgradeTree

func _ready() -> void:
	level = GameState.get_upgrade_level(title)
	tree_parent = find_parent("UpgradeTree")

	if dependency != null:
		visible = false
		current_max_level = dependency.level
		dependency.pressed.connect(_on_dependency_pressed)
	else:
		current_max_level = max_level

	_refresh()

func is_maxed() -> bool:
	return level >= current_max_level

func _refresh() -> void:
	text = title
	$Price.text = "₡" + str(price)
	$Level.visible = max_level > 1

func _on_dependency_pressed() -> void:
	current_max_level = dependency.level if inherit_max_level and dependency.level < max_level else max_level
	disabled = is_maxed()

func _on_mouse_entered() -> void:
	if disabled:
		return
	tree_parent.side_panel.show_text()
	tree_parent.side_panel.set_title(title)
	tree_parent.side_panel.set_description(description)

func _on_mouse_exited() -> void:
	tree_parent.side_panel.hide_text()

func _on_pressed() -> void:
	if price > GameState.money:
		tree_parent.animation_player.stop()
		tree_parent.animation_player.play("not_enough")
		return

	level += 1
	GameState.money -= price
	GameState.upgrade(title)
	price = round(price * price_multiplier)
	disabled = is_maxed()
	_refresh()

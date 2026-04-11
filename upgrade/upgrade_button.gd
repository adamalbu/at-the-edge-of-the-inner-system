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
	print(title, level)
	tree_parent = find_parent("UpgradeTree")
	
	if dependency != null:
		visible = false
		dependency.pressed.connect(_on_dependency_pressed)
	else:
		current_max_level = max_level

	_refresh()

func is_maxed() -> bool:
	return level >= current_max_level

func _refresh() -> void:
	text = title
	$Price.text = "₡" + str(calculate_price())
	$Level.visible = max_level > 1
	
	if dependency != null and not Engine.is_editor_hint():
		var dep_level = GameState.get_upgrade_level(dependency.title)
		current_max_level = dep_level if inherit_max_level and dep_level < max_level else max_level
	
	disabled = is_maxed()

func calculate_price() -> int:
	var tmp_price = price
	for i in range(level):
		tmp_price *= price_multiplier
	return tmp_price

func _on_dependency_pressed() -> void:
	_refresh()

func _on_mouse_entered() -> void:
	if disabled:
		return
	tree_parent.side_panel.show_text()
	tree_parent.side_panel.set_title(title)
	tree_parent.side_panel.set_description(description)

func _on_mouse_exited() -> void:
	tree_parent.side_panel.hide_text()

func _on_pressed() -> void:
	if calculate_price() > GameState.money:
		tree_parent.animation_player.stop()
		tree_parent.animation_player.play("not_enough")
		return

	GameState.money -= calculate_price()
	GameState.upgrade(title)
	level += 1
	_refresh()

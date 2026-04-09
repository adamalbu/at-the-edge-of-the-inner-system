extends Control

@onready var animation_player: AnimationPlayer = $FullAnimationPlayer
@onready var total_money_label: Label = $RunInfo/Background/TotalMoney
@onready var added_money_label: Label = $RunInfo/Background/AddedMoney

func _ready() -> void:
	self.animate()

func animate() -> void:
	added_money_label.text = "₡" + str(GameState.run_money)
	set_display_total_money(GameState.money)
	animation_player.play("part_1")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://upgrade/upgrade_ui.tscn")

func tween_add_money() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_method(set_display_total_money, GameState.money, GameState.money + GameState.run_money, 1)
	
	GameState.money += GameState.run_money

func set_display_total_money(money: int) -> void:
	total_money_label.text = "₡" + str(money)

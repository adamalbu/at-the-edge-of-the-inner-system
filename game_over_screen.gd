extends ColorRect

@onready var animation_player = $AnimationPlayer
@onready var money_label = $Money

@export var simple_transition: ColorRect

func _ready():
	visible = false

func show_game_over():
	visible = true
	money_label.text = "₡" + str(GameState.run_money)
	animation_player.play("show")
	
	await animation_player.animation_finished
	
	await simple_transition.slide_in()
	get_tree().change_scene_to_file("res://upgrade/upgrade_ui.tscn")

func tween_remove_money() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_method(display_money, GameState.run_money, 0, 1)
	
	GameState.run_money = 0

func reset_timescale() -> void:
	Engine.time_scale = 1.0

func display_money(money: int) -> void:
	money_label.text = "₡" + str(money)

func _process(delta: float) -> void:
	if animation_player.is_playing():
		animation_player.speed_scale = 1 / Engine.time_scale

extends ColorRect


func show_game_over():
	$Control/Label.text = "₡" + str(GameState.money)
	$AnimationPlayer.play("show_game_over")

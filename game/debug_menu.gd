extends VBoxContainer

func _ready() -> void:
	if OS.get_cmdline_args().has("--debug-menu"):
		visible = true
	else:
		visible = false

func _on_kill_pressed() -> void:
	$"../../Player".health = 0

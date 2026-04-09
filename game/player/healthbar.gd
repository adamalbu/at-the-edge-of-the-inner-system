extends ColorRect

var max_width

@export var player: RigidBody2D
@onready var fg = $HealthbarFG

func _ready() -> void:
	max_width = size.x

func _process(_delta: float) -> void:
	fg.size.x = (player.health / player.max_health) * max_width

extends Camera2D

@onready var player = $"../Sprite2D"

var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y -= delta * 100
	
	time += delta
	player.position.y -= delta * 100
	player.position.x = position.x + sin(time) * 40

extends Node2D

const DELETE_DISTANCE = 2000

@export
var player: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var distance= (player.position - self.position).length()
	if distance > DELETE_DISTANCE:
		self.queue_free()

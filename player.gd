extends Sprite2D

const SPEED = 200
const DRAG = 1.001
const ANGULAR_SPEED = 0.01
const ANGULAR_DRAG = 1.001

var velocity = Vector2(0, 0)
var	direction = Vector2(0, 0)
var angular_velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2(0, 0)

	if Input.is_action_pressed("forward"):
		direction.y -= 1
	if Input.is_action_pressed("backwards"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		angular_velocity -= ANGULAR_SPEED * delta
	if Input.is_action_pressed("right"):
		angular_velocity += ANGULAR_SPEED * delta

	angular_velocity /= ANGULAR_DRAG
	self.rotation += angular_velocity

	direction = direction.normalized()
	velocity += direction.rotated(rotation) * SPEED * delta
	velocity /= DRAG
	self.position += velocity

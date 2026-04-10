extends RigidBody2D

@export var max_health = 50.0
@export var laser_range = 200.0
var health = max_health

var controllable = true
var dead = false

signal game_over

func _ready() -> void:
	GameState.run_money = 0
	
	self.angular_damp = GameState.angular_damp
	self.linear_damp = GameState.linear_damp

func _draw() -> void:
	draw_circle(to_local(position), laser_range, Color(0.0, 1.0, 0.0, 0.3), false)

func _process(_delta: float) -> void:
	if health <= 0 && !dead:
		$AnimationPlayer.play("die")
		dead = true

	queue_redraw()

func _physics_process(_delta: float) -> void:
	$PlayerFlameSprite.visible = false
	
	if !controllable:
		return

	var thrust = 0.0
	if Input.is_action_pressed("forward"):
		thrust -= GameState.thrust
		$PlayerFlameSprite.visible = true
	if Input.is_action_pressed("backwards"):
		thrust += GameState.thrust

	if thrust != 0.0:
		apply_force(Vector2(0, thrust).rotated(rotation))
		

	var torque = 0.0
	if Input.is_action_pressed("left"):
		torque -= GameState.torque
	if Input.is_action_pressed("right"):
		torque += GameState.torque

	apply_torque(torque)

func _integrate_forces(state: PhysicsDirectBodyState2D):
	for i in state.get_contact_count():
		var impulse = state.get_contact_impulse(i).length()

		if impulse > 700:

			var lost_health = impulse * 0.0003

			health -= lost_health

func set_controllable():
	controllable = true

func set_uncontrollable():
	controllable = false

func send_game_over():
	game_over.emit()

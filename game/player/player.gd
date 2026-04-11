extends RigidBody2D

@export var max_health = 50.0
var health = max_health

var controllable = true
var dead = false

var last_speed: float
var last_impulse: float
var frames_since_damage: int

signal destroyed

func _ready() -> void:
	GameState.run_money = 0
	
	self.angular_damp = GameState.angular_damp
	self.linear_damp = GameState.linear_damp

func _draw() -> void:
	if !dead:
		draw_circle(to_local(position), GameState.range, Color(0.0, 1.0, 0.0, 0.3), false)

func _process(_delta: float) -> void:
	if health <= 0 && !dead:
		$AnimationPlayer.play("die")
		dead = true
		
		$PlayerSprite.visible = false
		$PlayerFlameSprite.visible = false
		$CollisionPolygon2D.set_deferred("disabled", true)
		$Fragments.show_fragments(linear_velocity, angular_velocity)
		$DeathParticles.position = $Fragments.get_average_pos()
		$DeathParticles.visible = true
		
		var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property(Engine, "time_scale", 0.01, 0.5)
		
	if dead:
		$Camera2D.position = $Fragments.get_average_pos()

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
	frames_since_damage += 1
	for i in state.get_contact_count():
		var impulse = state.get_contact_impulse(i).length()
		if (impulse > 700 or last_speed > 100) and frames_since_damage > 16:
			var lost_health = (last_speed ** 1.23) * 0.03
			health -= lost_health
			frames_since_damage = 0

	last_speed = linear_velocity.length()


func set_controllable():
	controllable = true

func set_uncontrollable():
	controllable = false

func send_game_over():
	print("asdf")
	destroyed.emit()

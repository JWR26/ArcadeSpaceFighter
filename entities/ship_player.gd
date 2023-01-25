# --- Class ---
class_name Player2D

# --- Extends ---
extends Ship2D

# --- Siganls ---


# --- ENUMS ---


# --- Constants ---
const THRUST_IMPULSE_FACTOR = 10.0
const TURN_IMPULSE_FACTOR = 50.0

const MAX_TURN_SPEED = PI

const MAX_SPEED = 100
const MAX_DAMP = 20

# --- Exported Variables ---


# --- Public Variables ---


# --- Private Variables ---
var laser_available: bool = false setget set_laser_available
var laser_active: bool = false

# --- Onready Variables ---


# --- Virtual _init method ---


# --- Virtual _ready method ---


# --- Virtual methods ---
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("fire_laser") and laser_available and $LaserTimer.is_stopped():
		laser_active = true
		$Laser.set_is_firing(true)
		$LaserTimer.start()
	
	if Input.is_action_just_pressed("stop"):
		angular_damp = MAX_DAMP
		linear_damp = MAX_DAMP


func _physics_process(delta: float) -> void:
	
	# turn the player by applying a torque if angular speed is less than max
	var turn: float = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
	# manipulate angular damping to stop the ship spinning too much.
	if turn == 0.0:
		angular_damp = clamp(angular_damp + delta, 0.5, MAX_DAMP)
	else:
		angular_damp = 0.5
	
	if angular_velocity < MAX_TURN_SPEED:
		apply_torque_impulse(turn*TURN_IMPULSE_FACTOR)
	else:
		pass
	
	# thrust goes "backwards" to push player forwards
	var thrust_input: float = Input.get_action_strength("break") - Input.get_action_strength("thrust")
	var thrust_impulse: Vector2 = (thrust_input * THRUST_IMPULSE_FACTOR) * transform.y
	
	if thrust_input == 0.0:
		linear_damp = clamp(linear_damp + delta, 0.25, MAX_DAMP)
	else:
		linear_damp = 0.25
	
	apply_central_impulse(thrust_impulse)
	
	# fire the cannon
	if Input.is_action_pressed("fire_cannon") and $CannonTimer.is_stopped() and !laser_active:
		_shoot()
	# update powerup displays
	$Camera/Camera2D/CanvasLayer/HUD.update_bouncing_bullet_timer($BouncingBulletTimer.time_left)
	if !$LaserTimer.is_stopped():
		$Camera/Camera2D/CanvasLayer/HUD.update_laser_timer($LaserTimer.time_left)


# --- Public methods ---


# --- Private methods ---
func _shoot() -> void:
	_fire_projectile(
		$LeftCannon.get_global_position(), 
		-transform.y, 
		self,
		$ProjectileContainer
	)
	_fire_projectile(
		$RightCannon.get_global_position(), 
		-transform.y, 
		self, 
		$ProjectileContainer
	)
	$CannonTimer.start(0.25)

func _on_Player_body_entered(body: Node) -> void:
	take_damage(1)


func _on_BouncingBulletTimer_timeout() -> void:
	set_bouncing_bullets_active(false)


func _on_LaserTimer_timeout() -> void:
	laser_available = false
	laser_active = false
	$Laser.set_is_firing(false)
	$Camera/Camera2D/CanvasLayer/HUD.update_laser_timer(0.0)

# --- SetGet functions ---
func set_laser_available(value: bool = false) -> void:
	laser_available = value
	
	if laser_available:
		$LaserTimer.one_shot = true
		$LaserTimer.wait_time = 3.0
		$Camera/Camera2D/CanvasLayer/HUD.update_laser_timer($LaserTimer.wait_time)

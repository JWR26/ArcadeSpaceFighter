# --- Class ---
class_name GravityZone2D

# --- Extends ---
extends Area2D

# --- Siganls ---


# --- ENUMS ---


# --- Constants ---
const MAX_GRAVITY: float = 500.00

# --- Exported Variables ---


# --- Public Variables ---


# --- Private Variables ---


# --- Onready Variables ---


# --- Virtual _init method ---
func _init(radius: float) -> void:
	_set_collision_shape(radius)
	set_gravity_is_point(true)
	set_gravity_vector(Vector2.ZERO)
	set_gravity(MAX_GRAVITY)
	set_space_override_mode(SPACE_OVERRIDE_REPLACE)

# --- Virtual _ready method ---


# --- Virtual methods ---


# --- Public methods ---


# --- Private methods ---
# Set the area of influence of the gravity zone.
func _set_collision_shape(radius: float) -> void:
	var owner: int = create_shape_owner(self)
	var shape: CircleShape2D = CircleShape2D.new() 
	shape.set_radius(radius)
	shape_owner_add_shape(owner, shape)

# --- SetGet functions ---


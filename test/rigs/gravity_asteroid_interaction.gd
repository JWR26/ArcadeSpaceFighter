# --- Class ---


# --- Extends ---
extends Node2D

# --- Siganls ---


# --- ENUMS ---


# --- Constants ---
const ASTEROID_A_POS = Vector2(200, 500)
const ASTEROID_B_POS = Vector2(800, 500)

# --- Exported Variables ---


# --- Public Variables ---


# --- Private Variables ---


# --- Onready Variables ---


# --- Virtual _init method ---


# --- Virtual _ready method ---
func _ready() -> void:
	spawn_asteroid_with_gravity(ASTEROID_A_POS, ASTEROID_B_POS)
	spawn_asteroid_with_gravity(ASTEROID_B_POS, ASTEROID_A_POS)

# --- Virtual methods ---


# --- Public methods ---
func spawn_asteroid_with_gravity(pos: Vector2, at: Vector2) -> void:
	var a = Asteroid.new(true)
	a.set_position(pos)
	add_child(a)
	a.fling_at(at)


# --- Private methods ---


# --- SetGet functions ---


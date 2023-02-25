# --- Class ---


# --- Extends ---
extends Node2D

# --- Siganls ---


# --- ENUMS ---


# --- Constants ---
var GRAVITY_ASTEROID_POSITION: Vector2 = Vector2(960, 540)

# --- Exported Variables ---


# --- Public Variables ---


# --- Private Variables ---


# --- Onready Variables ---


# --- Virtual _init method ---


# --- Virtual _ready method ---
func _ready() -> void:
	randomize()
	spawn_asteroid_with_gravity()
	$GravityAsteroidSpawner.start(20)
	$AsteroidSpawner.start(1.0)
	$ProjectileSpawner.start(0.2)

# --- Virtual methods ---


# --- Public methods ---
func spawn_asteroid_with_gravity() -> void:
	var a = Asteroid.new(true)
	a.set_position(GRAVITY_ASTEROID_POSITION)
	$EntityContainer.add_child(a)


func spawn_normal_asteroid() -> void:
	var a = Asteroid.new(false)
	a.set_position(Vector2(240,135))
	$EntityContainer.add_child(a)
	a.fling_at(Vector2(1920,270))


# --- Private methods ---


# --- SetGet functions ---



func _on_GravityAsteroidSpawner_timeout() -> void:
	for entity in $EntityContainer.get_children():
		entity.queue_free()
	
	spawn_asteroid_with_gravity()


func _on_AsteroidSpawner_timeout() -> void:
	spawn_normal_asteroid()


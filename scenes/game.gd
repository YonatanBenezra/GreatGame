extends Node2D
@export var enemy_scene: PackedScene
@onready var spawn_timer = $SpawnTimer 
@export var spawnTime: float = 4.0  # Initial spawn interval (seconds)
@export var minSpawnTime: float = 0.5  # Minimum interval (limit)
@export var spawnDecreaseRate: float = 0.1  # How much to decrease each time

func _ready():
	spawn_timer.timeout.connect(spawn_enemy)  # Call spawn_enemy() when the timer runs out
	spawn_timer.start(spawnTime) 
	



func spawn_enemy():
	
	var min_distance = 800  # Minimum distance from base
	var max_distance = 1700  # Maximum distance from base
	var playerHub = get_node("Hub")
	var random_position = get_random_position(playerHub.global_position, min_distance, max_distance)
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_position
	add_child(enemy_instance) 
	
func get_random_position(center: Vector2, min_distance: float, max_distance: float)-> Vector2:
	spawnTime = max(spawnTime - spawnDecreaseRate, minSpawnTime)
	spawn_timer.start(spawnTime)
	var angle = randf_range(0, TAU)
	var distance = randf_range(min_distance, max_distance)
	var offset =Vector2(cos(angle), sin(angle)) * distance
	return center + offset

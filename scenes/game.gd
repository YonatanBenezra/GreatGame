extends Node2D
@export var enemy_scene: PackedScene
@onready var spawn_timer = $SpawnTimer 

func _ready():
	spawn_timer.timeout.connect(spawn_enemy)  # Call spawn_enemy() when the timer runs out
	spawn_timer.start(3)  # Spawns an enemy every 3 seconds

func spawn_enemy():
	var spawn_points = get_tree().get_nodes_in_group("spawn_points")
	var spawn_point = spawn_points.pick_random()  # Choose a random marker
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = spawn_point.position  # Set enemy position
	add_child(enemy_instance) 

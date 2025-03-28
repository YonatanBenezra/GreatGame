extends CharacterBody2D

@onready var hotbarComponent = $HotBarComponent

var direction: Vector2 = Vector2.ZERO
@export var walkSpeed: int = 100
@export var currentBuilding: String = ""
@export var Bullet : PackedScene = preload("res://entities/weapons/Bullet/Bullet.tscn")
var sprintSpeed: int = 200
var speed = walkSpeed


func _ready() -> void:
	currentBuilding = hotbarComponent.getBuilding()
	print(currentBuilding)

func _process(_delta: float) -> void:
	
	# get vector returns normalized vector 
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("sprint"):
		speed = sprintSpeed
	if Input.is_action_just_released("sprint"):
		speed = walkSpeed
	if Input.is_action_just_pressed("shoot") && GlobalResources.bullets > 0:
		shoot_bullet()
		GlobalResources.bullets -= 1;
		
	look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func _on_hot_bar_component_updated_hotbar() -> void:
	currentBuilding = hotbarComponent.getBuilding()
	
func shoot_bullet() -> void:
	var bullet_instance = Bullet.instantiate()
	bullet_instance.position = global_position
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - bullet_instance.position).normalized()
	bullet_instance.shoot(direction)
	get_tree().current_scene.add_child(bullet_instance)
	

	

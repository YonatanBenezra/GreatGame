extends CharacterBody2D

@onready var hotbarComponent = $HotBarComponent

var direction: Vector2 = Vector2.ZERO
@export var walkSpeed: int = 100
@export var currentBuilding: String = ""
var sprintSpeed: int = 200
var speed = walkSpeed

func _ready() -> void:
	currentBuilding = hotbarComponent.getBuilding()
	print(currentBuilding)

func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("sprint"):
		speed = sprintSpeed
	if Input.is_action_just_released("sprint"):
		speed = walkSpeed
		
	look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func _on_hot_bar_component_updated_hotbar() -> void:
	currentBuilding = hotbarComponent.getBuilding()

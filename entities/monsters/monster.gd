extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
@export var walkSpeed: int = 90
@export var currentBuilding: String = ""
var hub: Sprite2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
var sprintSpeed: int = 100
var speed = 150

var curHP = 10;


func _ready() -> void:
	hub = get_tree().get_first_node_in_group("Hub")
	makepath()
	

func _physics_process(_delta: float) -> void:
	
	# Normilized the diraction before multiplying by vilocity to get a consistent speed for every diraction
	direction = to_local(nav_agent.get_next_path_position().normalized()).normalized()
	velocity = direction * speed
	
	move_and_slide()
	

func makepath()-> void:
	nav_agent.target_position = hub.global_position

func hit(damege):
	
	curHP -= damege;
	if(curHP <= 0):
		queue_free();

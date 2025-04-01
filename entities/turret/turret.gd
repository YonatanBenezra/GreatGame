extends Node2D


@export var BULLET: PackedScene = null

var target: Node2D = null
var cur_Hp =8

@onready var gunSprite = $GunSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/ReloadTimer


func _ready():
	await get_tree().process_frame
	target = find_target()

func _physics_process(delta):
	if target == null:
		target = find_target()
		
	if target != null:
		
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		rayCast.global_rotation = angle_to_target
		
		
		if rayCast.is_colliding() and rayCast.get_collider().is_in_group("Enemies"):
			gunSprite.rotation = angle_to_target
			if reloadTimer.is_stopped():
				shootBullet()
	
			

func shootBullet():
	rayCast.enabled = false
	
	if BULLET:
		var bullet: Node2D = BULLET.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		var direction = (target.global_position - bullet.global_position).normalized()
		bullet.shoot(direction)
	
	reloadTimer.start()

func find_target():
	var new_target: Node2D = null
	
	if get_tree().has_group("Enemies"):
		new_target = get_tree().get_nodes_in_group("Enemies")[0]
	
	return new_target

func hit(damage):
	cur_Hp -= damage;
	if(cur_Hp <= 0):
		queue_free()
		


func _on_building_collision_component_body_entered(body: Node2D) -> void:
	
	if(!body.is_in_group("Enemies")):
		return;
	
	body.hit(1000);
	hit(1);



func _on_reload_timer_timeout() -> void:
	rayCast.enabled = true

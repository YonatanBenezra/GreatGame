extends Area2D
var speed = 400;
var max_distance = 2000
var traveled_distance = 0
var direction =Vector2.ZERO

var damege = 1;

func _process(delta):
	var movement = direction * speed * delta
	position += movement
	traveled_distance += movement.length()
	if traveled_distance > max_distance:
		queue_free()
	
func _on_Bullet_body_entered(body):
	queue_free()
	
func shoot(dir:Vector2):
	direction = dir.normalized()
	rotation = direction.angle()


func _on_body_entered(body: Node2D) -> void:
	
	if(!body.is_in_group("Enemies")):
		return;
	
	body.hit(damege);
	queue_free();

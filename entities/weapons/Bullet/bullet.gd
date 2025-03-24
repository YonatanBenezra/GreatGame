extends Area2D
var speed = 400;
var max_distance = 2000
var traveled_distance = 0
var direction =Vector2.ZERO

func _process(delta):
	var movement = direction * speed * delta
	position += movement
	traveled_distance += movement.length()
	if traveled_distance > max_distance:
		queue_free()
	
func _on_Bullet_body_entered(body):
	queue_free()
	
func shoot(dir:Vector2):
	direction = dir
	rotation = direction.angle()

extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_released("zoom_out"):
		set_zoom(get_zoom() * 0.9)

	if Input.is_action_just_released("zoom_in"):
		set_zoom(get_zoom() * 1.1)
	
	if get_zoom() < Vector2(0.1, 0.1):
		set_zoom(Vector2(0.1, 0.1))
	
	if get_zoom() > Vector2(2, 2):
		set_zoom(Vector2(2, 2))

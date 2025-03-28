extends Node

signal resource_update(resource_type,resource_amount);

# Starting bullets
var bullets:int = 300:
	set(delta):
		bullets = delta
		emit_signal("resource_update","bullets",bullets);

# Starting iron
var iron:int = 100:
	set(delta):
		iron = delta;
		emit_signal("resource_update","iron",iron);

# Starting oil
var oil:int = 0:
	set(delta):
		oil = delta;
		emit_signal("resource_update","oil",oil);

extends Sprite2D


# can transfr to building comp
var cur_Hp = 10

func _ready() -> void:
	$IncrementTimer.connect("timeout", _on_Timer_timeout)
	$IncrementTimer.start(1)  # Start the timer with a 1-second interval

func _on_Timer_timeout():
	GlobalResources.oil += 1;

func hit(damage):
	cur_Hp -= damage;
	if(cur_Hp <= 0):
		print("Game Over")
		print("You extracted: "  + str(GlobalResources.oil) + " Oil")
		get_tree().quit();


func _on_building_collision_component_body_entered(body: Node2D) -> void:
	
	if(!body.is_in_group("Enemies")):
		return;
	
	body.hit(1000);
	hit(1);
	

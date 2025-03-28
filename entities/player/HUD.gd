extends Control

@onready var bullets_text = $Panel/HBoxContainer/Bullets/HBoxContainer2/Panel/Amount
@onready var iron_text = $Panel/HBoxContainer/Iron/HBoxContainer2/Panel/Amount
@onready var oil_text = $Panel/HBoxContainer/Oil/HBoxContainer2/Panel/Amount


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Update HUD at the start of the game
	UpdateHUD("bullets",GlobalResources.bullets)
	UpdateHUD("iron",GlobalResources.iron)
	UpdateHUD("oil",GlobalResources.oil)
	
	GlobalResources.connect("resource_update",UpdateHUD)

func UpdateHUD(resource_type,resource_amount)-> void:
	
	match resource_type:
		"bullets":
			bullets_text.text = str(resource_amount)
		"iron":
			iron_text.text = str(resource_amount)
		"oil":
			oil_text.text = str(resource_amount)
	
	

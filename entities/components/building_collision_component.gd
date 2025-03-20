extends Area2D

@export var buildingComponent: BuildingComponent
@export var selectionOverlay: Sprite2D
@export var building: Node

var mouse_over = false

func _ready() -> void:
	# ensure selectionOverlay starts invisible
	selectionOverlay.visible = false

func _process(_delta: float) -> void:
	if buildingComponent.buildingPlaced:
		# check if the mouse is inside the Area2D
		if get_global_mouse_position().distance_to(global_position) <= Global.GRIDSIZE / 2 * buildingComponent.buildingSize:
			if not mouse_over:
				# mouse just entered
				selectionOverlay.visible = true
				Global.HUD_SELECTION_OVERBUILDING = true
				Global.HUD_SELECTION_BUILDING = building
				mouse_over = true
		else:
			if mouse_over:
				# mouse just exited
				selectionOverlay.visible = false
				Global.HUD_SELECTION_OVERBUILDING = false
				Global.HUD_SELECTION_BUILDING = null
				mouse_over = false

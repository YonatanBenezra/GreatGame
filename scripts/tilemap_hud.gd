extends TileMapLayer

var gridSize := Global.GRIDSIZE
@onready var player := $"/root/game/player"

var object
var tileBuffer := Vector2(0, 0)
var tile: Vector2

var building
var selection_updated = false

var buildingSize: int

func _on_hot_bar_component_updated_hotbar() -> void:
	selection_updated = true

func _process(_delta: float) -> void:
	if Global.HUD_SELECTION_OVERBUILDING:
		visible = false
	else:
		visible = true
	rotateBuildings()
	tile = local_to_map(get_global_mouse_position())
	
	if tile != tileBuffer or selection_updated:
		building = player.currentBuilding
		getBuildingDetails()
		selection_updated = false

		#erase_cell(tileBuffer)
		#tileBuffer = tile
		#set_cell(tile, 0, Vector2(0,0), 0)
		
		if object:
			object.queue_free()
		previewBuilding(tile)


func previewBuilding(pos):
	object = load(building).instantiate()
	if buildingSize % 2 == 0:
		object.position = pos * gridSize + Vector2(gridSize, gridSize)
	else:
		object.position = pos * gridSize + Vector2(gridSize / 2, gridSize / 2)
	object.name = "preview"
	object.modulate.a = 0.2
	match Global.HUD_SELECTION_ROTATION:
		"south":
			object.set_rotation_degrees(0)
		"west":
			object.set_rotation_degrees(90)
		"north":
			object.set_rotation_degrees(180)
		"east":	
			object.set_rotation_degrees(270)
	add_child(object, true)

func getBuildingDetails():
	var objectDetails = load(building).instantiate()
	var buildingComponent = objectDetails.get_child(0)
	buildingSize = buildingComponent.buildingSize

func rotateBuildings():
	if Input.is_action_pressed("hud_alternativepress"):
		if Input.is_action_just_pressed("hud_rotation"):
			selection_updated = true
			match Global.HUD_SELECTION_ROTATION:
				"south":
					Global.HUD_SELECTION_ROTATION = "east"
				"west":
					Global.HUD_SELECTION_ROTATION = "south"
				"north":
					Global.HUD_SELECTION_ROTATION = "west"
				"east":	
					Global.HUD_SELECTION_ROTATION = "north"
	else:
		if Input.is_action_just_pressed("hud_rotation"):
			selection_updated = true
			match Global.HUD_SELECTION_ROTATION:
				"south":
					Global.HUD_SELECTION_ROTATION = "west"
				"west":
					Global.HUD_SELECTION_ROTATION = "north"
				"north":
					Global.HUD_SELECTION_ROTATION = "east"
				"east":	
					Global.HUD_SELECTION_ROTATION = "south"

#func _on_buildings_placed_building(occupiedTiles) -> void:
	#for tile in occupiedTiles:
		#set_cell(tile, 0, Vector2(0,0), 0)

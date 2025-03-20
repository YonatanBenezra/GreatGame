extends TileMapLayer

var gridSize = Global.GRIDSIZE
@onready var player = $"../player"
@onready var hotbarComponent = $"../player/HotBarComponent"

var buildingDic = {}
var occupiedTiles = []
var hotbarObjects = []

var buildingType
var buildingNumber = 0
var buildingSize
var buildingTier
var buildingPath

var object

signal placedBuilding

func _ready() -> void:
	for x in hotbarComponent.getHotbar():
		if x:
			hotbarObjects.append(load(x))
		else:
			hotbarObjects.append("null")

func _process(_delta: float) -> void:
	getBuildingDetails(hotbarObjects[Global.HUD_HOTBAR_CURRENTID].instantiate())
	var tile = Vector2(local_to_map(get_global_mouse_position()))
	placedBuilding.emit(occupiedTiles)
	
	if Input.is_action_pressed("left_click") and !Global.HUD_SELECTION_OVERBUILDING and !Functions.checkIfTilesOccupied(tile, buildingSize, occupiedTiles)[0]:
		object = hotbarObjects[Global.HUD_HOTBAR_CURRENTID].instantiate()
		placeBuilding(tile)
		
		for tileBuf in Functions.checkIfTilesOccupied(tile, buildingSize, occupiedTiles)[1]:
			print(str("append", tileBuf))
			occupiedTiles.append(tileBuf)
		print(occupiedTiles)
	
	if Input.is_action_pressed("right_click") and Global.HUD_SELECTION_OVERBUILDING and is_instance_valid(Global.HUD_SELECTION_BUILDING):
		Global.HUD_SELECTION_BUILDING.queue_free()
		getBuildingDetails(Global.HUD_SELECTION_BUILDING) # change to building placed
		var pos
		if buildingSize % 2 == 0:
			pos = (Global.HUD_SELECTION_BUILDING.position - Vector2(gridSize, gridSize)) / gridSize 
		else:
			pos = (Global.HUD_SELECTION_BUILDING.position - Vector2(gridSize / 2, gridSize / 2)) / gridSize 
		
		for tileBuf in Functions.checkIfTilesOccupied(pos, buildingSize, occupiedTiles)[1]:
			print(str("erase", tileBuf))
			occupiedTiles.erase(tileBuf)
		Global.HUD_SELECTION_OVERBUILDING = false
		print(occupiedTiles)

func placeBuilding(pos):
	if buildingSize % 2 == 0:
		object.position = pos * gridSize + Vector2(gridSize, gridSize)
	else:
		object.position = pos * gridSize + Vector2(gridSize / 2, gridSize / 2)
	object.name = str(buildingType, "_at", pos, "_facing", Global.HUD_SELECTION_ROTATION)
	updateBuildingDetails()
	match Global.HUD_SELECTION_ROTATION:
		"south":
			object.set_rotation_degrees(0)
		"west":
			object.set_rotation_degrees(90)
		"north":
			object.set_rotation_degrees(180)
		"east":	
			object.set_rotation_degrees(270)
	
	buildingDic[str(pos)] = {
		"Type": buildingType,
		"Rotation": Global.HUD_SELECTION_ROTATION,
		"Tier": buildingTier
	}
	add_child(object, true)

func updateBuildingDetails():
	var buildingComponent = object.get_child(0)
	buildingComponent.buildingPlaced = true
	buildingComponent.buildingType = buildingType
	buildingComponent.buildingSize = buildingSize
	buildingComponent.buildingTier = buildingTier

func getBuildingDetails(obj):
	var buildingComponent = obj.get_child(0)
	buildingType = buildingComponent.buildingType
	buildingSize = buildingComponent.buildingSize
	buildingTier = buildingComponent.buildingTier


func _on_hot_bar_component_updated_hotbar() -> void:
	hotbarObjects.clear()
	for x in hotbarComponent.hotBar:
		if x:
			hotbarObjects.append(load(x))
		else:
			hotbarObjects.append("null")

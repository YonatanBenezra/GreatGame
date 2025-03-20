extends Node

func checkIfTilesOccupied(tile, buildingSize, occupiedTiles):
	var currentTile; var occupiedTilesBuffer = []
	for x in buildingSize:
			if x > buildingSize / 2:
				x = (x * -1) % buildingSize / 2
			for y in buildingSize:
				if y > buildingSize / 2:
					y =  (y * -1) % buildingSize / 2
				currentTile = tile + Vector2(x, y)
				occupiedTilesBuffer.append(currentTile)
	
	for tileBuf in occupiedTilesBuffer:
		if occupiedTiles.has(tileBuf):
			return [true, occupiedTilesBuffer]
	
	return [false, occupiedTilesBuffer]

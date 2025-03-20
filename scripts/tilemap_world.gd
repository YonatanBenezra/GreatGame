extends TileMapLayer

var chunkSize = 16
var mapSize = 16
var dic = {}

var rng = RandomNumberGenerator.new()

func loadChunk(mapX, mapY):
	for x in chunkSize:
		for y in chunkSize:
			rng.randomize()
			match rng.randi_range(0, 4):
				0:
					dic[str(Vector2(x + mapX,y + mapY))] = {
						"Type": "Heavy Grass"
						}
					set_cell(Vector2(x + mapX,y + mapY), 0, Vector2(0,0), 0)
				1:
					dic[str(Vector2(x + mapX,y + mapY))] = {
						"Type": "Light Grass"
						}
					set_cell(Vector2(x + mapX,y + mapY), 0, Vector2(1,0), 0)
				2:
					dic[str(Vector2(x + mapX,y + mapY))] = {
						"Type": "Big Bushes"
						}
					set_cell(Vector2(x + mapX,y + mapY), 0, Vector2(2,0), 0)
				3:
					dic[str(Vector2(x + mapX,y + mapY))] = {
						"Type": "Small Bushes"
						}
					set_cell(Vector2(x + mapX,y + mapY), 0, Vector2(3,0), 0)
				4:
					dic[str(Vector2(x + mapX,y + mapY))] = {
						"Type": "Black"
						}
					set_cell(Vector2(x + mapX,y + mapY), 0, Vector2(4,0), 0)

func _ready():
	for x in mapSize * 2:
		if x > mapSize:
			x = (x * -1) % mapSize 
		for y in mapSize * 2:
			if y > mapSize:
				y =  (y * -1) % mapSize
			loadChunk(chunkSize	* x, chunkSize	* y)

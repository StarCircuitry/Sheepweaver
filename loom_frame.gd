extends Node2D
class_name LoomFrame

var tileMap : TileMapLayer
var pos : Vector2

func initializeFrame(_tileMap: TileMapLayer) -> void:
	print(position)
	tileMap = _tileMap
	position = getGridPosition(position)
	print(position)

func getGridPosition(_pos: Vector2) -> Vector2:
	return tileMap.map_to_local(tileMap.local_to_map(_pos))


func moveFrame(_pos: Vector2) -> void:
	position = GetNewFramePosition(_pos)

func GetNewFramePosition(_pos: Vector2) -> Vector2:
	var tileMapPosition = tileMap.local_to_map(position)
	# add to position based on value
	tileMapPosition = tileMapPosition + Vector2(0, 1)
	return tileMap.map_to_local(tileMapPosition)

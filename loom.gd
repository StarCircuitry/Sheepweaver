extends TileMapLayer

var GridWidth = 10
var GridHeight = 10
var LoomGrid = []
var mouseValue = 0
var mouseTile = Vector2i()
var layerCount = -1
var threads = []
const DEFAULT_LAYER = preload("res://thread_layer.tscn")

const mat1Pos = Vector2i(11, 4)
const mat2Pos = Vector2i(11, 6)

const undoPos = Vector2i(15, 5)

var GridStates = []

func initializeGridData() -> void:
	for col in range(GridWidth):
		LoomGrid.append([])
		for row in range(GridHeight):
			if ((row == 1 || row == GridHeight-1)):
				LoomGrid[col].append(1)
			elif ((row == 0 && col > 0) || ((row > 0 && row < GridHeight-1) && col == 0)):
				LoomGrid[col].append(4)
			else:
				LoomGrid[col].append(0)
	GridStates.append(LoomGrid.duplicate(true))

#func storeMove() -> void:
#	GridStates.append([])
#	for col in range(GridWidth):
#		GridStates[layerCount+1].append([])
#		for row in range(GridHeight):
			

func displayGridData() -> void:
	for col in range(GridWidth):
		for row in range(GridHeight):
			erase_cell(Vector2i(col, row))
			set_cell(Vector2(col, row), LoomGrid[col][row], Vector2(0, 0), 0)


func _ready() -> void:			
	initializeGridData()
	displayGridData()
	
	set_cell(mat1Pos, 2, Vector2(0, 0), 0)
	set_cell(mat2Pos, 3, Vector2(0, 0), 0)
	
	set_cell(undoPos, 0, Vector2(0, 0), 0)

func _process(delta: float) -> void:
	mouseTile = local_to_map(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if (mouseTile == mat1Pos || mouseTile == mat2Pos):
			GrabResource()
		elif (mouseTile == undoPos):
			UndoMove()
		elif ((mouseTile.y == 0 && mouseTile.x == 0) ||
		(mouseTile.x > GridWidth || mouseTile.y > GridHeight)):
			pass
		elif (mouseTile.y == 0 && (mouseValue in [2, 3])):	
			layerCount += 1
			var new_layer = DEFAULT_LAYER.instantiate()
			add_child(new_layer)
			threads.append(new_layer)
			
			for row in range(2, GridHeight-1):
				LoomGrid[mouseTile.x][row] = mouseValue
				new_layer.set_cell(Vector2(mouseTile.x, row), mouseValue,
				Vector2(0, 0), 0)
			GridStates.append(LoomGrid.duplicate(true))
				
		elif (mouseTile.x == 0):
			layerCount += 1
			var new_layer = DEFAULT_LAYER.instantiate()
			add_child(new_layer)
			threads.append(new_layer)
			
			for col in range(1, GridWidth):
				LoomGrid[col][mouseTile.y] = mouseValue
				new_layer.set_cell(Vector2(col, mouseTile.y), mouseValue,
				Vector2(0, 0), 0)
			GridStates.append(LoomGrid.duplicate(true))

func UndoMove() -> void:
	if (layerCount >= 0):
		print(GridStates)
		var lastMove = threads.get(layerCount) as TileMapLayer
		threads.remove_at(layerCount)
		lastMove.queue_free()
		GridStates.remove_at(layerCount+1)
		LoomGrid = GridStates[layerCount]
		layerCount -= 1
		print(GridStates)

func GrabResource() -> void:
	mouseValue = get_cell_source_id(mouseTile)

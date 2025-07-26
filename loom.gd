extends TileMapLayer

var GridWidth = 10
var GridHeight = 10
var LoomGrid = []
var mouseValue = 0
var mouseTile = Vector2i()
var layerCount = -1
var threads = []
const DEFAULT_LAYER = preload("res://thread_layer.tscn")

var goalPattern = []
var GridStates = []

## LOOM FRAME CONSTANTS ##
const FRAME_ROW = 1
const FRAME_VERT_OFFSET = 1
const PEG_ROW = 0
const PEG_COL = 0


## BUTTON LOCATIONS ##
const mat1Pos = Vector2i(11, 4)
const mat2Pos = Vector2i(11, 6)
const mat3Pos = Vector2i(11, 8)
const color1Pos = Vector2i(12, 4)
const color2Pos = Vector2i(12, 6)

const undoPos = Vector2i(15, 5)
const checkmePos = Vector2i(15, 7)
const toMapButton = Vector2i(17, 6)

## TILESET INDICES ##
const EMPTY = 0
const LOOM_FRAME = 1
const COTTON = 2
const LINEN = 3
const WOOL = 4
const LOOM_PEG = 5
const BLUE = 6
const RED = 7

## TILESET VARIANT INDICES
const VERTICAL = 0		# y index
const HORIZONTAL = 1		# y index
const NUM_VARIANTS = 0	# Can use this to generate random wtihin a range

func initializeGridData() -> void:
	for col in range(GridWidth):
		LoomGrid.append([])
		for row in range(GridHeight):
			if ((row == FRAME_ROW || row == GridHeight-FRAME_VERT_OFFSET)):
				LoomGrid[col].append(LOOM_FRAME)
			elif ((row == PEG_ROW && col > 0) || ((row > 0 && row < GridHeight-1) && col == PEG_COL)):
				LoomGrid[col].append(LOOM_PEG)
			else:
				LoomGrid[col].append(EMPTY)
	GridStates.append(LoomGrid.duplicate(true))
	goalPattern = LoomGrid.duplicate(true)

func displayGridData() -> void:
	for col in range(GridWidth):
		for row in range(GridHeight):
			erase_cell(Vector2i(col, row))
			set_cell(Vector2(col, row), LoomGrid[col][row], Vector2(0, 0), 0)


func _ready() -> void:
	initializeGridData()
	displayGridData()
	
	set_cell(mat1Pos, COTTON, Vector2(0, 0), 0)
	set_cell(mat2Pos, LINEN, Vector2(0, 0), 0)
	set_cell(mat3Pos, WOOL, Vector2(0, 0), 0)
	
	set_cell(color1Pos, BLUE, Vector2(0, 0), 0)
	set_cell(color2Pos, RED, Vector2(0, 0), 0)
	
	set_cell(undoPos, EMPTY, Vector2(0, 0), 0)
	set_cell(checkmePos, LOOM_PEG, Vector2(0, 0), 0)
	set_cell(toMapButton, LOOM_PEG, Vector2(0, 0), 0)

func _process(_delta: float) -> void:
	mouseTile = local_to_map(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if (mouseTile == mat1Pos || mouseTile == mat2Pos || mouseTile == mat3Pos):
			GrabResource()
		elif (mouseTile == undoPos):
			UndoMove()
		elif (mouseTile == checkmePos):
			CheckMe()
		elif (mouseTile == toMapButton):
			print("Going exploring...")
		elif ((mouseTile.y == 0 && mouseTile.x == 0) ||
		(mouseTile.x > GridWidth || mouseTile.y > GridHeight)):
			pass
		elif (mouseTile.y == 0 && (mouseValue in range(2, 5))):	
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

func CheckMe() -> void:
	if (LoomGrid == goalPattern):
		set_cell(checkmePos, LOOM_FRAME, Vector2i(0, 0), 0)
	
	

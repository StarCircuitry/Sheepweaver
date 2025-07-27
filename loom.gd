extends TileMapLayer

var GridWidth = 10
var GridHeight = 10
var LoomGrid = []
var mouseValue = 0
var mouseColor = Vector3(1., 1., 1.)
var mouseTile = Vector2i()
var layerCount = -1
var threads = []

## For adjusting the loom frame ##
var RaisedRow = 5

## Color IDs ##
const PLAIN = 0
const CLAY = 1

## Shader Stuff	##
const DEFAULT_LAYER = preload("res://thread_layer.tscn")

const COTTON_MATERIAL = preload("res://Materials/cotton_color.tres")
const LINEN_MATERIAL = preload("res://Materials/linen_color.tres")
const WOOL_MATERIAL = preload("res://Materials/wool_color.tres")

# Also read in the inventory file
var col1 = 1
var col2 = 2
var col3 = 3

var goalPattern = []
var GridStates = []
var FrameXIsUsed = []


## LOOM FRAME CONSTANTS ##
const FRAME_ROW = 1
const FRAME_VERT_OFFSET = 1
const PEG_ROW = 0
const PEG_COL = 0

## BUTTON LOCATIONS ##
const mat1Pos = Vector2i(11, 4)
const mat2Pos = Vector2i(11, 6)
const mat3Pos = Vector2i(11, 8)

# TODO: set good positions and initialize to right color
const color1Pos = Vector2i(12, 4)
const color2Pos = Vector2i(12, 6)
const color3Pos = Vector2i(12, 8)
const waterPos = Vector2i(12, 10)



const undoPos = Vector2i(15, 5)
const checkmePos = Vector2i(15, 7)
const toMapButton = Vector2i(17, 6)

## TILESET INDICES ##
const EMPTY = 0

const COTTON = 2
const LINEN = 3
const WOOL = 4
const LOOM_PEG_TOP = 6
const LOOM_PEG_SIDE = 7
const TABLETOP = 23
const TABLETOP_COORDS = Vector2i(4, 3)
const LOOM_FRAME = 8
const BUTTON_CHECK = 20
const BUTTON_MAP = 21
const BUTTON_UNDO = 22

const COLOR_TILE_OFFSET = 10

## TILESET VARIANT INDICES	##
const VERTICAL_VARIANTS = [0, 2, 4, 6, 8]		# x index
const HORIZONTAL_VARIANTS = [1, 3, 5, 7, 9]		# y index
const NUM_VARIANTS = 5	# Can use this to generate random wtihin a range

func initializeGridData() -> void:
	for col in range(GridWidth):
		LoomGrid.append([])
		for row in range(GridHeight):
			if (row == FRAME_ROW):
				LoomGrid[col].append(LOOM_FRAME)
				FrameXIsUsed.append(0)
			elif (row == GridHeight-FRAME_VERT_OFFSET):
				LoomGrid[col].append(LOOM_FRAME)
			elif (row == PEG_ROW && col > 0):
				LoomGrid[col].append(LOOM_PEG_TOP)
			elif ((row > 0 && row < GridHeight-1) && col == PEG_COL):
				LoomGrid[col].append(LOOM_PEG_SIDE)
			else:
				LoomGrid[col].append(EMPTY)
	GridStates.append(LoomGrid.duplicate(true))


func displayGridData() -> void:
	for col in range(GridWidth):
		for row in range(GridHeight):
			erase_cell(Vector2i(col, row))
			
			#TODO : Loom frame stuff
			var x = 2 if row == GridHeight-1 else 0
			set_cell(Vector2(col, row), LoomGrid[col][row],
			Vector2(0, x), 0)

func _ready() -> void:
	initializeGridData()
	displayGridData()
	
	set_cell(mat1Pos, COTTON, Vector2(0, 0), 0)
	set_cell(mat2Pos, LINEN, Vector2(0, 0), 0)
	set_cell(mat3Pos, WOOL, Vector2(0, 0), 0)
	
	set_cell(color1Pos, col1+COLOR_TILE_OFFSET, Vector2(0, 0), 0)
	set_cell(color2Pos, col2+COLOR_TILE_OFFSET, Vector2(0, 0), 0)
	set_cell(color3Pos, col3+COLOR_TILE_OFFSET, Vector2(0, 0), 0)
	set_cell(waterPos, COLOR_TILE_OFFSET, Vector2(0, 0), 0)
	
	set_cell(undoPos, BUTTON_UNDO, Vector2(0, 0), 0)
	set_cell(checkmePos, BUTTON_CHECK, Vector2(0, 0), 0)
	set_cell(toMapButton, BUTTON_MAP, Vector2(0, 0), 0)
	
	set_cell(Vector2(0, 0), TABLETOP, Vector2(0, 0), 0)
	
	#DisplayGoalPattern(0)
	

func _process(_delta: float) -> void:
	mouseTile = local_to_map(get_global_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if (mouseTile == mat1Pos || mouseTile == mat2Pos || mouseTile == mat3Pos):
			GrabResource()
		elif (mouseTile == color1Pos|| mouseTile == color2Pos ||
			mouseTile == color3Pos || mouseTile == waterPos):
			ApplyColor()
		elif (mouseTile == undoPos):
			UndoMove()
		elif (mouseTile == checkmePos):
			DisplayGoalPattern()
		elif (mouseTile == toMapButton):
			MoveToMap()
		elif ((mouseTile.y == 0 && mouseTile.x == 0) ||
		(mouseTile.x > GridWidth-1 || mouseTile.y > GridHeight-1)):
			pass
		elif (mouseTile.y == 0 && (mouseValue in range(COTTON, WOOL+1))):
			layerCount += 1
			var new_layer = DEFAULT_LAYER.instantiate()
			add_child(new_layer)
			threads.append(new_layer)
			
			FrameXIsUsed[mouseTile.x] = 1
			
			for row in range(2, GridHeight-1):
				LoomGrid[mouseTile.x][row] = mouseValue
				new_layer.set_cell(Vector2(mouseTile.x, row), mouseValue,
				Vector2(VERTICAL_VARIANTS[randi() % NUM_VARIANTS], 0), 0)
				
			set_cell(Vector2(mouseTile.x, FRAME_ROW), LOOM_FRAME, Vector2(0, 1), 0)
			set_cell(Vector2(mouseTile.x, GridHeight-1), LOOM_FRAME, Vector2(0, 3), 0)
			GridStates.append(LoomGrid.duplicate(true))
			
		elif (mouseTile.x == 0 && mouseValue in range(COTTON, WOOL+1)):
			layerCount += 1
			var new_layer = DEFAULT_LAYER.instantiate()
			add_child(new_layer)
			threads.append(new_layer)
			
		#	ApplyFrameMaterial()
			
			for col in range(1, GridWidth):
				LoomGrid[col][mouseTile.y] = mouseValue
				new_layer.set_cell(Vector2(col, mouseTile.y), mouseValue,
				Vector2(HORIZONTAL_VARIANTS[randi() % NUM_VARIANTS], 0), 0)
			GridStates.append(LoomGrid.duplicate(true))
		elif (LoomGrid[mouseTile.x][mouseTile.y] == LOOM_FRAME):
			AdjustFrame()

func UndoMove(frameMove: bool=false) -> void:
	print(GridStates)
	if (layerCount >= 0):
		var lastMove = threads.get(layerCount) as TileMapLayer
		threads.remove_at(layerCount)
		lastMove.queue_free()
		GridStates.remove_at(layerCount+1)
		LoomGrid = GridStates[layerCount].duplicate(true)
		layerCount -= 1
		print(GridStates)

func GrabResource() -> void:
	mouseValue = get_cell_source_id(mouseTile)
	

func ApplyColor() -> void:
	if (mouseTile == color1Pos || mouseTile == color2Pos || mouseTile == color3Pos ||
		mouseTile == waterPos):
		mouseColor = get_cell_source_id(mouseTile)-COLOR_TILE_OFFSET	
	if (mouseValue == COTTON):
		COTTON_MATERIAL.set_shader_parameter("fabricColor1", LoomGlobals.colors[mouseColor][0])
		COTTON_MATERIAL.set_shader_parameter("fabricColor2", LoomGlobals.colors[mouseColor][1])
		COTTON_MATERIAL.set_shader_parameter("fabricColor3", LoomGlobals.colors[mouseColor][2])
	elif (mouseValue == LINEN):
		LINEN_MATERIAL.set_shader_parameter("fabricColor1", LoomGlobals.colors[mouseColor][0])
		LINEN_MATERIAL.set_shader_parameter("fabricColor2", LoomGlobals.colors[mouseColor][1])
		LINEN_MATERIAL.set_shader_parameter("fabricColor3", LoomGlobals.colors[mouseColor][2])
	elif (mouseValue == WOOL):
		WOOL_MATERIAL.set_shader_parameter("fabricColor1", LoomGlobals.colors[mouseColor][0])
		WOOL_MATERIAL.set_shader_parameter("fabricColor2", LoomGlobals.colors[mouseColor][1])
		WOOL_MATERIAL.set_shader_parameter("fabricColor3", LoomGlobals.colors[mouseColor][2])		

func CheckMe() -> void:
	if (LoomGrid == goalPattern):
		set_cell(checkmePos, LOOM_FRAME, Vector2i(0, 0), 0)

func MoveToMap() -> void:
	print("Going exploring...")
	Global.goto_scene("res://Map/Scenes/MapScene.tscn")
	

func AdjustFrame() -> void:
	
	var col = mouseTile.x
	var frameRow = mouseTile.y
	
	print(frameRow)
	print(RaisedRow)
	
	if frameRow != RaisedRow:
		#FrameMoveIndices[col].append(layerCount)
		layerCount += 1
		var mask_layer = DEFAULT_LAYER.instantiate()
		add_child(mask_layer)
		threads.append(mask_layer)
		mask_layer.top_level = true
		LoomGrid[col][RaisedRow] = LoomGrid[col][GridHeight-FRAME_VERT_OFFSET]
		mask_layer.set_cell(Vector2(col, RaisedRow),
			LoomGrid[col][GridHeight-FRAME_VERT_OFFSET], Vector2(0, 0), 0)
		for row in range(RaisedRow+1, GridHeight):
			LoomGrid[col][row] = EMPTY
			mask_layer.set_cell(Vector2(col, row), TABLETOP, TABLETOP_COORDS, 0)

	GridStates.append(LoomGrid.duplicate(true))
	

func DisplayGoalPattern(goalNum: int=0) -> void:
	if (goalNum < 3):
		goalPattern = LoomGlobals.GOAL_PATTERNS[goalNum]
		var goal_layer = DEFAULT_LAYER.instantiate()
		add_child(goal_layer)
		goal_layer.top_level = true
		goal_layer.modulate.a = 0.5
		
		for col in range(GridWidth):
			for row in range(GridHeight):
				goal_layer.erase_cell(Vector2i(col, row))
				goal_layer.set_cell(Vector2(col, row), goalPattern[col][row][0], Vector2(0, 0), 0)	
		pass


	

#const level0 = [
#	[[(0, 0), (1, 0), (5, 0), (5, 0), (5, 0), (5, 0), (5, 0), (5, 0), (5, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
# 	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)],
#	[(5, 0), (1, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (1, 0)]]
#]

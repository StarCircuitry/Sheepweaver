extends Control

@onready var inventory : Inventory = preload("res://Map/InventoryFolder/PlayerInventory.tres")
@onready var slots : Array = $NinePatchRect/CenterContainer/GridContainer.get_children()
var is_open = false

func _ready():
	if inventory: #will catch signal here
		inventory.connect("inventory_changed", Callable(self, "update_slots"))
	update_slots()
	close()
	
	
func update_slots():
	print_debug("UPDATING SLOTS")
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("basket"):
		#print_debug("b")
		if is_open:
			close()
		else:
			open()
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

extends Resource

class_name Inventory
signal inventory_changed  #will release signal here
@export var items: Array[InventoryItem]

var slotNameToIndex = {
	"InventoryUISlot": 0,
	"InventoryUISlot2": 1,
	"InventoryUISlot3": 2,
	"InventoryUISlot4": 3,
	"InventoryUISlot5": 4,
	"InventoryUISlot6": 5,
	"InventoryUISlot7": 6,
	"InventoryUISlot8": 7,
	"InventoryUISlot9": 8,
	"InventoryUISlot10": 9
}

#check indices with aster, NEEDS to match InventoryItem name
var itemToColorIndex = {
	"White" : 0,
	"Clay" : 1,
	"Yellow" : 2,
	"Lime Green" : 3, #pending
	"Blue" : 4,
	"Purple" : 5, #pending
	"Pink" : 6, #pending
	"Black" : 7,
}

func add_item(newItem: InventoryItem):
	var count = items.filter(func(item):
		return item != null and not item.is_empty()
	).size()

	var index = 0
	if count < 10:
		while items[index] && items[index].name!="" && index<10:
			index += 1
		items[index] = newItem
		emit_signal("inventory_changed")  # Signal instead of direct call

func remove_item(slotName: String):
	print_debug(items)
	print_debug(slotName, items[slotNameToIndex[slotName]])
	if items[slotNameToIndex[slotName]]:
		items[slotNameToIndex[slotName]] = InventoryItem.new()
		print_debug(items[slotNameToIndex[slotName]] )
		emit_signal("inventory_changed")  # Signal instead of direct call
		
func getColors() -> Array[int]:
	var colors = []
	for item in items:
		if item.name in itemToColorIndex.keys():
			if itemToColorIndex[item.name] not in colors:
				colors.append(itemToColorIndex[item.name])
		else:
			print_debug("warning, item.name not found", item.name)
	return colors

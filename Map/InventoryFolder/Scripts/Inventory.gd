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

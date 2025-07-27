extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/ItemDisplay
var currentItem : InventoryItem
@onready var delete_item : Button = $DeleteButton
var playerInventory = load("res://Map/InventoryFolder/PlayerInventory.tres")


func update(item : InventoryItem):
	if !item or item.name=="":
		item_visual.visible = false
		delete_item.visible = false
	else:
		item_visual.visible = true
		delete_item.visible = true
		item_visual.texture = item.texture

func hideItem():
	#empties the cell here
	playerInventory.remove_item(self.name)
	item_visual.visible = false
	delete_item.visible = false

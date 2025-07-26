extends Resource

class_name InventoryItem

@export var name : String =""
@export var texture : Texture2D

func is_empty() -> bool:
	return name.strip_edges() == "" and texture == null

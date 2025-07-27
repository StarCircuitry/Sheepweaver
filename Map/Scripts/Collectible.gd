extends Node2D

var state = "ready to pick"
var player_in_area = false
@export var item : InventoryItem
@export var collectibleRadius : float = 20.0
var playerInventory = load("res://Map/InventoryFolder/PlayerInventory.tres")

func _ready():
	$InteractButtons.hide()
	if state == "picked":
		$CollectingCooldown.start()

		
func _process(_delta):
	if state == "picked":
		pass
	if state == "ready to pick":
		if player_in_area:
		# display picking prompt pop up 
		# needs to be set in input map
			if Input.is_action_pressed("interact"):
				state = "picked"
				$CollectingParticles.emitting = true
				$CollectingCooldown.start()
				playerInventory.add_item(item)

func _on_collectible_area_body_entered(body):
	if body is CharacterBody2D:
		player_in_area	= true
		$InteractButtons.show()

		
func _on_collectible_area_body_exited(body):
	if body is CharacterBody2D:
		player_in_area	= false
		$InteractButtons.hide()
		
func _on_collecting_cooldown_timeout():
	if state == "picked":
		state = "ready to pick"

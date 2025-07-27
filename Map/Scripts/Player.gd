extends CharacterBody2D
#moves to pixels/second
@export var move_speed : float = 80.0

@export var inventory : Inventory



func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed

	move_and_slide()

func player():
	pass

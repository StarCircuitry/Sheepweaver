extends Node2D

func _ready():
	$NinePatchRect.hide()
	
func _on_return_home_area_body_entered(body):
	if body is CharacterBody2D:
		$NinePatchRect.show()

		
func _on_return_home_area_body_exited(body):
	if body is CharacterBody2D:
		$NinePatchRect.hide()

func _on_return_home_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
#		change scene back to shop HERE
		print_debug("go home")
		pass

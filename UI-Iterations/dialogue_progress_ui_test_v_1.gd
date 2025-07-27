extends Control

func _on_proceed_pressed() -> void:
	print("Proceed Button is Pressed")
	DialogueManager.show_dialogue_balloon(get_parent().resources, get_parent().stage1)
	get_parent().set_visible(false)

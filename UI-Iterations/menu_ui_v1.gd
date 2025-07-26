extends Control


func _on_startGame_pressed() -> void:
	print("Start Game Button is Pressed")


func _on_options_pressed() -> void:
	print("Options Button is Pressed")


func _on_exitGame_pressed() -> void:
	get_tree().quit()

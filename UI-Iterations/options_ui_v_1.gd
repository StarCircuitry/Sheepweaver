extends Control

func _on_returnback_pressed() -> void:
	print("Return Button is Pressed")
	%MenuUI.show()
	%OptionUI.hide()

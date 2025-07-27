extends Control

func _on_startGame_pressed() -> void:
	print("Start Game Button is Pressed")
	Global.goto_scene("res://scenes/LoomScene.tscn")
	# DISABLED OPENING CUTSCENE FOR NOW
	# Global.goto_scene("res://scenes/day1-intro.tscn")

func _on_options_pressed() -> void:
	print("Options Button is Pressed")
	%MenuUI.hide()
	%OptionUI.show()

func _on_exitGame_pressed() -> void:
	get_tree().quit()

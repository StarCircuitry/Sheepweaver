## menu.gd
extends Node

# We need to add a connection back from the main gameplay loop to the main game

func _on_menu_button_pressed():
	print_debug("Return to menu triggered")
	#Global.goto_scene("res://menu.tscn")

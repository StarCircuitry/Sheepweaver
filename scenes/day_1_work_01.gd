extends Node2D

var resources = load("res://Dialogue/Day1-work01.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resources, "start")

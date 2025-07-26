extends Node2D

var resources = load("res://Dialogue/Day1-startV2.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resources, "start")

extends Node2D

var resources = load("res://Dialogue/Day1-end.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resources, "start")

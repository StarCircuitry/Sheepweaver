extends Node2D

var day1_d1 = load("res://Dialogue/Day1-startV1.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(day1_d1, "start")

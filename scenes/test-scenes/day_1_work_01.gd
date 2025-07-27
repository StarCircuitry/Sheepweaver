extends Node2D
var resources = load("res://dialogue/Day1-work01.dialogue")

func _ready() -> void:
	_start_dialogue()
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)

func _start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(resources, "start")

func _on_dialogue_manager_dialogue_ended(_resource: DialogueResource) -> void:
	%Progression_work01.show()

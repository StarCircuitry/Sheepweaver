extends Control

func _ready() -> void:
	hide()

func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true

func testEsc():
	if Input.is_physical_key_pressed(KEY_P) and get_tree().paused == false:
		get_tree().paused = true
		show()
		
	elif Input.is_physical_key_pressed(KEY_P) and get_tree().paused == true:
		get_tree().paused = false
		hide()

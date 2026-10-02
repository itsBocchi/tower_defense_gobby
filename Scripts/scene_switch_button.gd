extends Button   # or extends Control if you need a container

@export_file("*.tscn") var target_scene: String = ""

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if target_scene.is_empty():
		print("Error: No target scene assigned.")
		return
	get_tree().change_scene_to_file(target_scene)

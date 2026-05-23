extends CanvasLayer

@export var nextScene : StringName = &""

func _on_button_pressed() -> void:
	SceneLoader.load_scene(nextScene)

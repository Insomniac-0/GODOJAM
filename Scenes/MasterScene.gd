extends Node

@export var initialScene : StringName = &""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	SceneLoader.load_scene(initialScene)
	

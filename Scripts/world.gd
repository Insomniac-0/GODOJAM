extends Node3D
@onready var player = $PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_camera($Camera3D)
	player.world = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().call_group("Enemies", "update_target_location", player.position)

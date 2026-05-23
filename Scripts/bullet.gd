class_name Bullet extends Node3D

var moveDir := Vector3.ZERO
@export var defaultSpeed : float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moveDir = Vector3.RIGHT


func setDirection(direction : Vector3):
	moveDir = direction
	transform.basis.z = -direction
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += moveDir * defaultSpeed * delta

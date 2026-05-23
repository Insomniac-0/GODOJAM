extends Camera3D
@onready var player: CharacterBody3D = $"../PlayerCharacter"
var targetPosition:= Vector3.ZERO
@export var lerpSpeed: float = 20
@export var positionOffset:= Vector3.ZERO
var mousePos:= Vector2.ZERO
var mouseOffset := Vector2.ZERO;
var mouseLook := Vector3.ZERO
@export var mouseInfluence = 20
@export var mouseInfluenceThreshold = 0.5
@export var mouseInfluenceLerp = 5
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	targetPosition = Vector3(player.position.x,0,player.position.z)
	
	mousePos = get_viewport().get_mouse_position()
	
	mouseOffset.x = (mousePos.x/get_viewport().size.x*2)-1
	mouseOffset.y = (mousePos.y/get_viewport().size.y*2)-1
	
	if (mouseOffset.length() < mouseInfluenceThreshold):
		mouseOffset = Vector2.ZERO
	else:
		mouseOffset = mouseOffset.normalized()
	
	print(mouseOffset)
	mouseLook = mouseLook.lerp(Vector3(mouseOffset.x,0,mouseOffset.y),mouseInfluenceLerp*delta)
	targetPosition += mouseLook * mouseInfluence
	
	position = position.lerp(targetPosition+positionOffset,lerpSpeed*delta)
	print(position)

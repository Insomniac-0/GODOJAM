extends Camera3D
@onready var player: CharacterBody3D = $"../PlayerCharacter"

#Following the player
var targetPosition:= Vector3.ZERO
@export var lerpSpeed: float = 20
@export var positionOffset:= Vector3.ZERO

#Offsetting in Mouse Direction
var mousePos:= Vector2.ZERO
var mouseOffset := Vector2.ZERO;
var mouseLook := Vector3.ZERO
@export var mouseInfluence = 20
@export var mouseInfluenceThreshold = 0.5
@export var mouseInfluenceLerp = 5

#Screenshake
@export var decay : float = 0.8
@export var maxShakeOffset := Vector2(100,75)
@export var maxRoll : float = 0.1
var trauma : float = 0.0
var traumaPower : int = 2
var shakeOffset : Vector2 = Vector2.ZERO

func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Set Target Position
	targetPosition = Vector3(player.position.x,0,player.position.z)
	
	# Look at mouse
	mousePos = get_viewport().get_mouse_position()
	mouseOffset.x = (mousePos.x/get_viewport().size.x*2)-1
	mouseOffset.y = (mousePos.y/get_viewport().size.y*2)-1
	
	if (mouseOffset.length() < mouseInfluenceThreshold):
		mouseOffset = Vector2.ZERO
	else:
		mouseOffset = mouseOffset.normalized()
	
	mouseLook = mouseLook.lerp(Vector3(mouseOffset.x,0,mouseOffset.y),mouseInfluenceLerp*delta)
	targetPosition += mouseLook * mouseInfluence
	
	# Shake the camera
	if trauma:
		trauma = max(trauma - decay * delta, 0)
	
	var amount = pow(trauma, traumaPower)
	shakeOffset.x = maxShakeOffset.x * amount * randf_range(-1,1)
	shakeOffset.y = maxShakeOffset.y * amount * randf_range(-1,1)
	
	# Set real position
	position = position.lerp(targetPosition+positionOffset,lerpSpeed*delta)	
	position += Vector3(shakeOffset.x,0,shakeOffset.y)

func addTrauma(amount : float) -> void:
	trauma = min(trauma + amount, 1.0)
	

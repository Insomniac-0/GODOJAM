class_name Projectile extends Node3D

signal end_of_life(projectile: Projectile)

@onready var area : Area3D = $Area3D

@export var defaultSpeed : float = 20.0
@export var defaultLifetime : float = 0.5

var moveDirection : Vector3 = Vector3.FORWARD
var moveSpeed : float = 0.0
var lifetime : float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moveSpeed = defaultSpeed
	lifetime = defaultLifetime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += moveDirection * moveSpeed * delta
	lifetime -= delta
	
	if(lifetime <= 0.0):
		end_of_life.emit(self)

func set_direction(direction : Vector3):
	moveDirection = direction

func set_speed(speed : float):
	moveSpeed = speed
	
func set_lifetime(time : float):
	lifetime = time

func handle_collision(body: CharacterBody3D) -> void:
	if(body.is_in_group("Enemies")):
		body.get_child(4).take_damage(10)
		
		print("Collision with Enemy")

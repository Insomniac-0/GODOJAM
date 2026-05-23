extends CharacterBody3D
var camera : Camera3D
var world : Node3D

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var input_component: InputComponent = $InputComponent
@onready var bulletSpawn: Node3D = $MeshInstance3D/BulletSpawn
@onready var shootTimer: Timer = $Timer
@onready var rollTimer: Timer = $RollTimer

@export var bullet : PackedScene
@export var shootKnockback : float = 10
@export var baseShootDelay : float = 0.2
var canShoot := true

@export var maxSpeed = 5.0
@export var acceleration = 0.5
@export var deacceleration = 1
var angleToMouse : float = 0

@export var rollForce : float = 5
@export var rollDecay : float = 0.8
@export var rollTime : float = 1
var currentlyRolling := false

func _ready() -> void:
	shootTimer.wait_time = baseShootDelay
	rollTimer.wait_time = rollTime

func _process(delta: float) -> void:
	if (!currentlyRolling):
		input_component.update()
		if (canShoot) and (input_component.shootPressed):
			shoot_bullet()
			camera.addTrauma(0.4)
			canShoot = false
			shootTimer.start()
		look_at_cursor()
		
	pass

func _physics_process(delta: float) -> void:
	if (!currentlyRolling):
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := (transform.basis * Vector3(input_component.moveDir.x, 0, input_component.moveDir.y)).normalized()
		if direction:
			velocity = velocity.lerp(Vector3(direction.x * maxSpeed, velocity.y, direction.z * maxSpeed),acceleration)
			input_component.update()
			if (input_component.rollPressed):
				roll(direction)
		else:
			velocity.x = move_toward(velocity.x, 0, deacceleration)
			velocity.z = move_toward(velocity.z, 0, deacceleration)
	else:
		velocity *= rollDecay

	move_and_slide()

func shoot_bullet():
	var shootDirection = -mesh.transform.basis.z;
	var instance : Bullet = bullet.instantiate()
	world.add_child(instance)
	instance.global_position = bulletSpawn.global_position
	instance.setDirection(shootDirection)
	velocity += -shootDirection * shootKnockback
	print("BANG")

func roll(direction : Vector3):
	print("ROLLING")
	velocity += direction * rollForce
	currentlyRolling = true
	rollTimer.start()

func set_camera(currentCamera : Camera3D):
	camera = currentCamera

func look_at_cursor():
	var targetPlaneMouse = Plane(Vector3(0,1,0), position.y)
	var rayLength = 1000
	var mousePosition = get_viewport().get_mouse_position()
	if (camera):
		var from = camera.project_ray_origin(mousePosition)
		var to = from + camera.project_ray_normal(mousePosition)*rayLength
		var cursorPositionOnPlane = targetPlaneMouse.intersects_ray(from, to)
		
		$MeshInstance3D.look_at(cursorPositionOnPlane,Vector3.UP,0)
	else:
		print("FUCK")

func _on_timer_timeout() -> void:
	canShoot = true


func _on_roll_timer_timeout() -> void:
	currentlyRolling = false

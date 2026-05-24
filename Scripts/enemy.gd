class_name Enemy extends CharacterBody3D
signal death(enemy : Enemy)

@onready var nav_agent = $NavigationAgent3D
@onready var healthComponent = $Health_Component
@onready var wind_timer: Timer = $WindTimer

@export var baseSpeed : float = 2.0
@export var windUpSpeed : float = 1
@export var chargeSpeed : float = 4.0
@export var speedLerp : float = 0.2
var currentSpeed : float = 2.0

@export var playerFarThreshold := 12.0
@export var playerCloseThreshold := 8.0
var windingUp := false
var charging := false

#func Physics_Update(delta: float) -> void:
	#var new_velocity = (direction).normalized() * SPEED
	
	#enemy.velocity = enemy.velocity.move_toward(new_velocity, 0.25)
	#enemy.move_and_slide()
	
	#if (direction.Length() > 100):
		#Transitioned.emit(self,"EnemyIdle")
	
#func update_target_location(target_locaction: Vector3):
		#nav_agent.target_position = target_locaction

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var direction = next_location - current_location
	var new_velocity = (direction).normalized() * currentSpeed
	
	var distance_to_player = (current_location - nav_agent.target_position).length()
	
	if (windingUp):
		currentSpeed = lerp(-windUpSpeed,baseSpeed,speedLerp)
	elif (charging):
		currentSpeed = lerp(chargeSpeed,baseSpeed,speedLerp)
		if (distance_to_player > playerFarThreshold):
			charging = false
	else:
		currentSpeed = lerp(currentSpeed,baseSpeed,speedLerp)
		if distance_to_player < playerCloseThreshold:
			windingUp = true
			wind_timer.start()
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
	

func update_target_location(target_locaction: Vector3):
	nav_agent.target_position = target_locaction

func on_health_changed(old_value: float, new_value: float) -> void:
	print("DAMAGED")

func on_death() -> void:
	print("Deaadasss")
	death.emit(self)

func _on_wind_timer_timeout() -> void:
	windingUp = false
	charging = true

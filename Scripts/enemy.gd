class_name Enemy extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var healthComponent = $Health_Component
var SPEED = 3.0

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	move_and_slide()
	
	
func update_target_location(target_locaction: Vector3):
		nav_agent.target_position = target_locaction


func on_health_changed(old_value: float, new_value: float) -> void:
	print("DAMAGED")


func on_death() -> void:
	print("Deaadasss")
	queue_free()

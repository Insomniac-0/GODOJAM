extends State
class_name EnemyCharge

@export var enemy: CharacterBody2D
@onready var nav_agent: NavigationAgent3D = $"../../NavigationAgent3D"

#var SPEED = 3.0

#func Physics_Update(delta: float) -> void:
	#var new_velocity = (direction).normalized() * SPEED
	
	#enemy.velocity = enemy.velocity.move_toward(new_velocity, 0.25)
	#enemy.move_and_slide()
	
	#if (direction.Length() > 100):
		#Transitioned.emit(self,"EnemyIdle")
	
#func update_target_location(target_locaction: Vector3):
		#nav_agent.target_position = target_locaction

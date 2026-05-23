class_name Health_Component extends Node

# Export Parameters
@export var max_health: float = 100

var current_health: float = 0.0

# Signals
signal health_depleted
signal health_changed(old_value: float, new_value: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(dmg: float):
	var old_health = current_health
	current_health = clamp(0, max_health, current_health - dmg)	
	
	health_changed.emit(old_health, current_health)
	
	if (current_health <= 0.0):
		health_depleted.emit()

func heal(amount: float):
	var old_health = current_health
	current_health = clamp(0, max_health, current_health + amount)
	
	health_changed.emit(old_health, current_health)
	
	if (current_health <= 0.0):
		health_depleted.emit()
		
		

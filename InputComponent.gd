class_name InputComponent extends Node
var moveDir : Vector2 = Vector2.ZERO
var shootPressed := false
var shootReleased := false
func update() -> void:
	moveDir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	shootPressed = Input.is_action_pressed("Shoot")

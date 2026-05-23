extends Control

@onready var highest_label = %HighestLabel
@onready var current_label = %CurrentLabel

var current_score = 0 :
	set (x) : current_score = x; current_label.text = str(x)
	
func _on_add_score_pressed():
	current_score += 1


func _on_save_score_pressed():
	if current_score > SaveLoad.highest_record :
		SaveLoad.highest_record = current_score
		highest_label.text = str(current_score)
	SaveLoad.save_score()

extends Control

@onready var add_score_button: Button = $VBoxContainer/AddScoreButton
@onready var save_score_button: Button = $VBoxContainer/SaveScoreButton


@onready var highest_label: Label = $VBoxContainer/HighestLabel
@onready var current_label: Label = $VBoxContainer/CurrentLabel

var _current_score = 0

var current_score :
	get:
		return _current_score
	set(x):
		_current_score = x
		current_label.text = str(x)
	

func _on_add_score_button_pressed() -> void:
	current_score += 1



func _on_save_score_button_pressed() -> void:
	if current_score > SaveLoad.highest_record :
		SaveLoad.highest_record = current_score
		highest_label.text = str(current_score)

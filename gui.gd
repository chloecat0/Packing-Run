extends MarginContainer

@onready var points_number_label := $HBoxContainer/Points/Background/Number

func _on_body_score_updated(new_score: Variant) -> void:
	points_number_label.text = "%s"%int(floor(new_score))

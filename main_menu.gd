extends MarginContainer

@onready var credits_label := $HBoxContainer/CenterContainer/CreditsLabel
@onready var start_button := $HBoxContainer/VBoxContainer/MenuOptions/Start

func _ready() -> void:
	start_button.grab_focus.call_deferred()

func _on_exit_pressed() -> void:
	get_tree().quit(0)

func _on_credits_toggled(toggled_on: bool) -> void:
	credits_label.visible = toggled_on

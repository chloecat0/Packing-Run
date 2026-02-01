extends MarginContainer

@onready var player : CharacterBody2D

func _ready() -> void:
	#update_buttons()
	pass

func update_buttons():
	if not player:
		return
	radius_button.text = radius_text % [player.max_radius, radius_cost]
	radius_button.disabled = player.score < radius_cost
	
	speed_button.text = speed_text % [player.speed/100, speed_cost]
	speed_button.disabled = player.score < speed_cost
	
	sticky_button.text = sticky_text % [player.max_time_on_wall, sticky_cost]
	sticky_button.disabled = player.score < sticky_cost
	
	bouncy_button.text = bouncy_text % [player.jump_impulse/10, bouncy_cost]
	bouncy_button.disabled = player.score < bouncy_cost

@onready var radius_button := $CenterContainer/VBoxContainer/Radius
var radius_text: String = "Radius %.1f
%.1f points"
var radius_cost: float = 5
func radius_pressed() -> void:
	if not player:
		return
	if player.score >= radius_cost:
		player.update_score(player.score - radius_cost)
		player.max_radius += 5
		radius_cost *= 1.5
		update_buttons()

@onready var speed_button := $CenterContainer/VBoxContainer/RollSpeed
var speed_text: String = "Roll Speed %.1f
%.1f points"
var speed_cost: float = 3
func roll_speed_pressed() -> void:
	if not player:
		return
	if player.score >= speed_cost:
		player.update_score(player.score - speed_cost)
		player.speed *= 1.4
		speed_cost *= 1.5
		update_buttons()

@onready var sticky_button := $CenterContainer/VBoxContainer/Stickiness
var sticky_text : String = "Stickiness %.1f
%.1f points"
var sticky_cost: float = 8
func stickiness_pressed() -> void:
	if not player:
		return
	if player.score >= sticky_cost:
		player.update_score(player.score - sticky_cost)
		player.max_time_on_wall += 0.2
		sticky_cost *= 1.5
		update_buttons()

@onready var bouncy_button := $CenterContainer/VBoxContainer/Bounciness
var bouncy_text : String = "Bounciness %.1f
%.1f points"
var bouncy_cost: float = 5
func bounciness_pressed() -> void:
	if not player:
		return
	if player.score >= bouncy_cost:
		player.update_score(player.score - bouncy_cost)
		player.jump_impulse *= 1.4
		bouncy_cost *= 1.5
		update_buttons()


func _on_player_body_score_updated(_new_score: float) -> void:
	update_buttons()

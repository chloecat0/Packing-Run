extends Node2D

@onready var terrain_generator := $TerrainGenerator
@onready var player := $Player/PlayerBody
@onready var gui := $CanvasLayer/GUI
@onready var upgrade_ui := $CanvasLayer/Upgrades
@onready var main_menu := $CanvasLayer/MainMenu
@onready var player_draw := $Player
@onready var music := $Music

func _ready() -> void:
	upgrade_ui.player = player
	upgrade_ui.update_buttons()
	player.connect("game_ended", end)
	music.play()

func start():
	terrain_generator.generate_start_terrain()
	terrain_generator.timer.start()
	player.reset()
	player_draw.reset()
	gui.visible = true
	upgrade_ui.visible = false
	main_menu.visible = false

func end():
	if main_menu.visible:
		return
	terrain_generator.timer.stop()
	upgrade_ui.visible = true
	upgrade_ui.radius_button.grab_focus.call_deferred()

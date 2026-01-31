extends Node2D

@export var terrain_object: PackedScene = preload("res://TerrainObject.tscn")
@onready var player

@export var min_height: int = 650
@export var max_height: int = 450

@export var min_width: int = 160
@export var max_width: int = 230
var next_x: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_start_terrain()

func spawn_terrain():
	clear_old_terrain()
	var new_terrain: Node2D = terrain_object.instantiate()
	add_child(new_terrain)
	var camera = get_viewport().get_camera_2d()
	var camera_size = get_viewport_rect().size * camera.zoom
	#var next_x = last_x + randi_range(min_width, max_width) 
	#max(last_x, (camera.get_screen_center_position() + camera_size/2).x)
	new_terrain.global_position = Vector2(next_x, randi_range(min_height, max_height))
	next_x += randi_range(min_width, max_width) 
	#camera.get_screen_center_position() + camera_size/2

func generate_start_terrain():
	next_x = 0
	for i in range(5):
		var new_terrain: Node2D = terrain_object.instantiate()
		add_child(new_terrain)
		new_terrain.global_position = Vector2(next_x, randi_range(min_height, max_height))
		next_x += randi_range(min_width, max_width)

func clear_old_terrain():
	for child in get_children():
		if child.is_class("Timer"):
			continue
		if child.global_position.x < (next_x - 10000):
			child.queue_free()

func clear_all_terrain():
	for child in get_children():
		if child.is_class("Timer"):
			continue
		child.queue_free()

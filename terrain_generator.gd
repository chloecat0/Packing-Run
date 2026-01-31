extends Node2D

@export var terrain_object: PackedScene = preload("res://TerrainObject.tscn")
@onready var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_terrain():
	var new_terrain: Node2D = terrain_object.instantiate()
	add_child(new_terrain)
	var camera = get_viewport().get_camera_2d()
	var camera_size = get_viewport_rect().size * camera.zoom
	new_terrain.global_position = camera.get_screen_center_position() + \
		camera_size/2 + Vector2(randi_range(0,50), -randi_range(100, 300))

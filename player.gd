extends Node2D


var radius: float = 15
var centre_radius: float = 10
var empty_radius: float = 7

@export var tape_color: Color = Color.BLANCHED_ALMOND
@export var centre_color: Color = Color.BISQUE
@export var background_color: Color = Color.DIM_GRAY


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(position, radius, tape_color, true, -1, true)
	draw_circle(position, centre_radius, centre_color, true, -1, true)
	draw_circle(position, empty_radius, background_color, true, -1, true)

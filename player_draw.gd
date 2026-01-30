extends Node2D

var radius: float = 15
var centre_radius: float = 10
var empty_radius: float = 7

@export var tape_color: Color = Color.BLANCHED_ALMOND
@export var centre_color: Color = Color.BISQUE
@export var background_color: Color = Color.DIM_GRAY

@onready var body := $Movement

var line_points: PackedVector2Array = PackedVector2Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_points.append(body.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line_points.append(body.global_position)
	queue_redraw()

func _draw() -> void:
	draw_circle(body.global_position-Vector2(0,radius), radius, tape_color, true, -1, true)
	draw_circle(body.global_position-Vector2(0,radius), centre_radius, centre_color, true, -1, true)
	draw_circle(body.global_position-Vector2(0,radius), empty_radius, background_color, true, -1, true)
	draw_polyline(line_points, tape_color, 1, true)

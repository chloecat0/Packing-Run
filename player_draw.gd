extends Node2D

#var radius: float = 15
#var centre_radius: float = 10
#var empty_radius: float = 7

@export var tape_color: Color = Color.BLANCHED_ALMOND
@export var centre_color: Color = Color.BISQUE
@export var background_color: Color = Color.DIM_GRAY

@onready var body := $Movement

var line_start: Vector2

var tape_lines: PackedVector2Array = PackedVector2Array()
var prev_body_on_floor: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var body_on_floor: bool = body.is_on_floor()
	if body_on_floor:
		if tape_lines.is_empty():
			tape_lines.append(body.global_position + Vector2(0, body.radius))
		if body_on_floor != prev_body_on_floor:
			tape_lines.append(body.global_position + Vector2(0, body.radius))
		if tape_lines.size() % 2 != 0:
			tape_lines.append(body.global_position + Vector2(0, body.radius))
		tape_lines.set(tape_lines.size()-1, body.global_position + Vector2(0, body.radius))
	prev_body_on_floor = body_on_floor
	queue_redraw()

func _draw() -> void:
	draw_circle(body.global_position, body.radius, tape_color, true, -1, true)
	draw_circle(body.global_position, body.centre_radius, centre_color, true, -1, true)
	draw_circle(body.global_position, body.empty_radius, background_color, true, -1, true)
	if not tape_lines.is_empty():
		draw_multiline(tape_lines, tape_color, 1, true)

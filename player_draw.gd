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
var prev_body_on_wall: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var body_on_floor: bool = body.is_on_floor()
	var body_on_wall: bool = body.is_on_wall()
	var current_position #= body.global_position + Vector2(0, body.radius)
	#stop placing tape if out of tape
	if body.out_of_tape:
		queue_redraw() #still need to draw empty body
		return
	if body.get_slide_collision_count() > 0:
		for i in body.get_slide_collision_count():
			current_position = body.get_slide_collision(i).get_position()
			if body_on_floor or body_on_wall:
				if tape_lines.is_empty() or body_on_floor != prev_body_on_floor or abs(current_position.y - tape_lines[tape_lines.size()-1].y) > 0.1:
					tape_lines.append(current_position)
				if tape_lines.size() % 2 != 0:
					tape_lines.append(current_position)
				tape_lines.set(tape_lines.size()-1, current_position)
	prev_body_on_floor = body_on_floor
	prev_body_on_wall = body_on_wall
	queue_redraw()

func _draw() -> void:
	if not tape_lines.is_empty():
		draw_multiline(tape_lines, tape_color, 1, true)
	draw_circle(body.global_position, body.radius, tape_color, true, -1, true)
	draw_circle(body.global_position, body.centre_radius, centre_color, true, -1, true)
	draw_circle(body.global_position, body.empty_radius, background_color, true, -1, true)

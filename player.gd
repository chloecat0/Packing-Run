extends CharacterBody2D

var speed: float = 50

var radius: float = 15
var centre_radius: float = 10
var empty_radius: float = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#line_points.append(global_position)
	pass

func _input(event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT*speed
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#line_points.append(global_position)
	#queue_redraw()
	pass

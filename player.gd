extends CharacterBody2D

var speed: float = 2000
var gravity: float = 980
var jump_impulse: float = 200

var radius: float = 15
var centre_radius: float = 10
var empty_radius: float = 7

var radius_reduction: float = 1
var out_of_tape: bool = false

@onready var collision_circle := $CollisionShape2D
var collision_shape: CircleShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#line_points.append(global_position)
	collision_shape = CircleShape2D.new()
	collision_shape.radius = radius
	collision_circle.shape = collision_shape

func _physics_process(delta: float) -> void:
	if not out_of_tape:
		velocity.x = speed*delta
	else:
		velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity*delta
	elif Input.is_action_just_pressed("jump") && not out_of_tape:
		velocity.y = -jump_impulse
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_radius(radius_reduction*delta)

func update_radius(reduction: float = 0):
	radius -= reduction
	if radius < centre_radius:
		radius = centre_radius
		out_of_tape = true
	collision_shape.radius = radius

extends CharacterBody2D

@export var speed: float = 2000
@export var gravity: float = 980
@export var jump_impulse: float = 200

@export var radius: float = 15
@export var centre_radius: float = 10
@export var empty_radius: float = 7

@export var radius_reduction: float = 1
var out_of_tape: bool = false

var time_on_wall: float = 0
@export var max_time_on_wall: float = 1

@onready var collision_circle := $CollisionShape2D
var collision_shape: CircleShape2D

@onready var end_timer := $EndGameTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	elif Input.is_action_just_pressed("jump") && not out_of_tape && not is_on_wall():
		velocity.y = -jump_impulse
	
	if not out_of_tape && is_on_wall() && time_on_wall < max_time_on_wall:
		velocity.y = -speed*delta
		time_on_wall += delta
	else:
		#at top of a wall
		if time_on_wall > 0 and time_on_wall < max_time_on_wall:
			#velocity.y = -jump_impulse
			position += Vector2(1, 0) #move a bit to be on top of wall
		time_on_wall = 0
	move_and_slide()
	if position.y > 720:
		start_end_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_radius(radius_reduction*delta)

func update_radius(reduction: float = 0):
	radius -= reduction
	if radius < centre_radius:
		radius = centre_radius
		if not out_of_tape:
			start_end_timer()
		out_of_tape = true
	collision_shape.radius = radius

func start_end_timer():
	if end_timer.is_stopped():
		end_timer.start()

func end_run():
	print("Game Over")

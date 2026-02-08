extends CharacterBody2D

@export var speed: float = 2000
@export var gravity: float = 980
@export var jump_impulse: float = 200

@export var max_radius: float = 15
@export var radius: float = 15
@export var centre_radius: float = 10
@export var empty_radius: float = 7

@export var radius_reduction: float = 1
var out_of_tape: bool = false

var time_on_wall: float = 0
@export var max_time_on_wall: float = 0.5

@onready var collision_circle := $CollisionShape2D
var collision_shape: CircleShape2D

@onready var end_timer := $EndGameTimer
signal game_ended
var game_already_ended: bool = false

@export var score: float = 0
signal score_updated(new_score:float)
var last_x: float = 0

@export var start_position: Vector2 = Vector2(68, 324)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape = CircleShape2D.new()
	collision_shape.radius = radius
	collision_circle.shape = collision_shape
	reset()

func reset():
	global_position = start_position
	last_x = global_position.x
	out_of_tape = false
	radius = max_radius
	time_on_wall = 0
	end_timer.stop()
	game_already_ended = false

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
		if time_on_wall > 0:
			if time_on_wall < max_time_on_wall: #at top of a wall
				velocity.y = -min(jump_impulse, speed*delta)
				position += Vector2(1, 0) #move a bit to be on top of wall
				time_on_wall = 0
			else:
				start_end_timer()
	move_and_slide()
	if position.x - last_x > 0.1:
		update_score(score+(position.x-last_x)/100)
		last_x = position.x
	if position.y > 1000 && velocity.y > 0 && not (is_on_wall() && radius > centre_radius):
		start_end_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_radius(radius_reduction*delta)
	

func update_score(new_score):
	score = new_score
	score_updated.emit(score)

func update_radius(reduction: float = 0):
	radius -= reduction
	if radius < centre_radius:
		radius = centre_radius
		if not out_of_tape:
			start_end_timer()
		out_of_tape = true
	collision_shape.radius = radius

func start_end_timer():
	if not game_already_ended and end_timer.is_stopped():
		end_timer.start(1)

func end_run():
	game_ended.emit()
	game_already_ended = true
	out_of_tape = true
	#print("Game Over")

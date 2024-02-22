extends CharacterBody2D

@export var player_speed : float = 10
@export var step_amplitude = 0.3
@export var step_frequency = 0.3
@export var start_direction : Vector2 = Vector2(1, 0)

@export var dodge_speed : float = 130 
@export var dodge_duration : float = 0.3
@export var dodge_cooldown : float = 1.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var player_state = "idel" 

var dodge_timer : float = 0.0
var dodge_player_angle = 0
var step_time = 0
var grounded = 1
var step_angle = 0

var player_direction : Vector2 = Vector2(1,0) 
var input_direction : Vector2 = Vector2.ZERO

var temp_debug = 0

func _ready(): 
	update_animation_parameter(start_direction)

func _process(_delta):
	step_time += 1
	step_angle = rad_to_deg(step_amplitude * sin(step_time * step_frequency)) 

func _physics_process(_delta): 
	input_direction = Vector2( 
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.is_action_just_pressed("space") and player_state != "jump":
		start_dodge()
	elif input_direction != Vector2.ZERO and player_state != "jump":
		player_state = "walk"
	elif input_direction == Vector2.ZERO:
		player_state = "idel"
	
	if player_state == "jump":
		dodge_player_angle += 4.5
		dodge_timer -= _delta
		if dodge_timer <= 0:
			end_dodge()
			dodge_player_angle = 0
	
	update_animation_parameter(input_direction)
	
	state_change()
	move_and_slide()
	
	
func start_dodge():
	player_state = "jump"
	dodge_timer = dodge_duration

func end_dodge():
	dodge_timer = dodge_cooldown

func state_change():
	print(player_state)
	if velocity != Vector2.ZERO:
		state_machine.travel("idel")
		rotation_degrees = 0
	else:
		velocity = input_direction * player_speed
		state_machine.travel("walk")

func update_animation_parameter(move_input: Vector2): 
	if (move_input != Vector2.ZERO): 
		animation_tree.set("parameters/idel/blend_position", move_input)
		animation_tree.set("parameters/walk/blend_position", move_input)

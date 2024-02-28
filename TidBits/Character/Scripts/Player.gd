extends CharacterBody2D

@export var player_speed : float = 10
@export var start_direction : Vector2 = Vector2(1, 0)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var grounded : bool = 1

var player_direction : Vector2 = Vector2(1,0) 
var input_direction : Vector2 = Vector2.ZERO

var temp_debug = 0

func _ready(): 
	update_animation_parameter(start_direction)

func _process(_delta):
	pass

func _physics_process(_delta):
	input_direction = Vector2( 
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if input_direction != Vector2.ZERO: 
		player_direction = input_direction
	
	update_animation_parameter(input_direction)
	
	move_and_slide()

func get_grounded(): 
	return grounded 

func update_animation_parameter(move_input: Vector2): 
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/idel/blend_position", move_input)
		animation_tree.set("parameters/walk/blend_position", move_input)

func update_animation_state(state_name): 
	state_machine.travel(state_name)

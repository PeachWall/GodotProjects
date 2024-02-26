extends Node

@export var initial_state : State

var states : Dictionary = {}
var current_state : State

func _ready():
	for child in get_children():
		if child is State: 
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state: 
		initial_state.Enter()
		current_state = initial_state

func _process(delta): 
	if current_state:
		current_state.Update(delta)

func _physics_process(delta): 
	if current_state: 
		current_state.Physics_Update(delta)

func on_child_transition(State, new_state_name):
	if State != current_state: # check if state calling and new state are the same
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: # check if the state exists 
		return 
	
	if current_state: # check if we have a current state 
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
		

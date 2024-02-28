extends State
class_name Walk

@export var step_amplitude = 0.4
@export var step_frequency = 1

var step_time = 0

func update_rotation(time): 
	var step_angle = 0
	step_time += time * 10
	step_angle = rad_to_deg(step_amplitude * sin(step_time * step_frequency))
	return step_angle

func Enter(): 
	owner.grounded = true

func Update(delta: float): 
	owner.velocity = owner.input_direction * owner.player_speed
	owner.rotation_degrees = update_rotation(delta)
	
	if owner.input_direction == Vector2.ZERO:
		Transition_to.emit(self, "Idle")
		
	if Input.get_action_strength("space"):
		Transition_to.emit(self,"jump")

func Physics_Update(_delta: float):
	pass  
	

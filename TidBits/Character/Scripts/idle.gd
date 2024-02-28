extends State
class_name Idle

var input_direction : Vector2 = Vector2.ZERO

func Enter(): 
	owner.grounded = true
	owner.velocity = Vector2.ZERO
	owner.rotation_degrees = 0
	
func Update(delta: float): 
	if owner.input_direction != Vector2.ZERO:
		Transition_to.emit(self, "walk")
	
	if Input.get_action_strength("space"):
		Transition_to.emit(self,"jump")

			
	


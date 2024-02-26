extends State
class_name Idle

var input_direction : Vector2 = Vector2.ZERO

func Enter(): 
	owner.velocity = Vector2.ZERO
	
func Update(delta: float): 
	if owner.input_direction != Vector2.ZERO:
		if not owner.grounded:
			Transition_to.emit(self, "walk")
		else:
			Transition_to.emit(self,"jump")
			
	


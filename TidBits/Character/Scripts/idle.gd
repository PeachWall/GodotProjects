extends State
class_name Idle

var input_direction : Vector2 = Vector2.ZERO

func Enter(): 
	owner.velocity = Vector2.ZERO
	
func Update(): 
	if Input.is_action_just_pressed("space"):
		stateMachine.
	


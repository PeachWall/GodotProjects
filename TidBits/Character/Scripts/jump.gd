extends State
class_name Jump

@export var dodge_speed : float = 130
@export var dodge_duration : float = 0.2

var dodge_time = 0

var dodge_timer : float = 0.0
var dodge_player_angle = 0

func Enter(): 
	dodge_time = dodge_duration
	owner.grounded = false
	owner.velocity = owner.player_direction * dodge_speed 
	
func Update(delta: float): 
	if dodge_time > 0: 
		dodge_time -= delta
	elif owner.input_direction != Vector2.ZERO:
		Transition_to.emit(self,"walk")
	else: 
		Transition_to.emit(self, "idle")

	
	

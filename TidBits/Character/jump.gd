extends State
class_name Jump

@export var dodge_speed : float = 130 
@export var dodge_duration : float = 0.3

var current_time = 0
var input_direction : Vector2 = Vector2.ZERO


func Enter(): 
	owner.velocity = dodge_speed 
	
	
func Update(delta: float): 
	current_time 
	
	

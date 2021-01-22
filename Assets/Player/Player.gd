extends KinematicBody2D

var gravity = Vector2(0, -400)
var horizontal_speed : int = 400
var jump_strength : int = 100

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("jump")
	
	velocity = velocity.move_toward(input_vector.normalized() * horizontal_speed - gravity, delta * 800)
	
	if input_vector.y != 0:
		velocity.y = velocity.y - jump_strength
		
	velocity = move_and_slide(velocity)

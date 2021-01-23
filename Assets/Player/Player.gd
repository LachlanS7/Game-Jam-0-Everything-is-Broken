extends KinematicBody2D

export (PackedScene) var weapon

var gravity = Vector2(0, -1400)
var horizontal_speed : int = 100
var jump_strength : int = 500
var acceleration : int = 800


var velocity = Vector2.ZERO

func attack(mouse_pos: Vector2):
	var b = weapon.instance()
	owner.add_child(b)
	b.transform = transform
	b.set("target", mouse_pos)
	
func _input(event):
	if event.is_action_pressed("attack1"):
		attack(event.position - transform.origin)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("jump")
	
	velocity = velocity.move_toward(input_vector.normalized() * horizontal_speed, delta * acceleration)
	
	velocity -= gravity * delta;
		
	if is_on_floor() && input_vector.y != 0:
		velocity.y = velocity.y - jump_strength
		
	velocity = move_and_slide(velocity, Vector2.UP)


extends KinematicBody2D

onready var weapon_manager = owner.get_node("WeaponsManager")

var velocity = Vector2.ZERO
var gravity = Vector2(0, -1400)

var horizontal_speed : int = 100
var jump_strength : int = 500
var acceleration : int = 800

var selected_weapon_id : int = 0

func _input(event):
	if event.is_action_pressed("attack1"):
			var t = event.position - get_canvas_transform().origin - global_position
			weapon_manager.attack(selected_weapon_id, t)
			
	if event.is_action_pressed("prev_weapon"):
		selected_weapon_id -= 1
		if selected_weapon_id < 0:
			selected_weapon_id = weapon_manager.weapons.size() - 1
		weapon_manager.equip_weapon(selected_weapon_id)
		
	if event.is_action_pressed("next_weapon"):
		selected_weapon_id += 1
		if selected_weapon_id >= weapon_manager.weapons.size():
			selected_weapon_id = 0
		weapon_manager.equip_weapon(selected_weapon_id)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("jump")
	
	velocity = velocity.move_toward(input_vector.normalized() * horizontal_speed, delta * acceleration)
	
	velocity -= gravity * delta;
	
	if is_on_floor() && input_vector.y != 0:
		velocity.y = velocity.y - jump_strength
	
	velocity = move_and_slide(velocity, Vector2.UP)



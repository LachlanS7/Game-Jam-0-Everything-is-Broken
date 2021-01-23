extends KinematicBody2D

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var collision_shape = $CollisionShape2D
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
	#gravity = gravity.rotated(0.05 * delta)
	
	collision_shape.rotation = atan2(gravity.x, -gravity.y)
	sprite.rotation = atan2(gravity.x, -gravity.y)
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("jump")
	
	if is_on_floor():
		if input_vector.y != 0:
			animation_player.play("jump")
		elif input_vector.x == 0:
			animation_player.play("idle")
		else:
			animation_player.play("walk")
		
	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
	
	velocity = velocity.move_toward((Vector2(input_vector.normalized().x, 0) * horizontal_speed).rotated(atan2(gravity.x, -gravity.y)), delta * acceleration)
	
	velocity -= gravity * delta;
	
	if is_on_floor() && input_vector.y != 0:
		velocity = velocity + jump_strength * gravity.normalized()
	
	velocity = move_and_slide(velocity, gravity.normalized())

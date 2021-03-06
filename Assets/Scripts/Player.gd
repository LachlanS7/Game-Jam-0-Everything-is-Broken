extends KinematicBody2D

onready var sprite = $Sprite
onready var health_bar = $HeathBar
onready var animation_player = $AnimationPlayer
onready var collision_shape = $CollisionShape2D

export (Array, int) var inventory

onready var weapon_manager = $WeaponsManager
onready var gravity_manager = owner.get_node("GravityManager")

var velocity = Vector2.ZERO

var horizontal_speed : int = 200
var jump_strength : int = 500
var acceleration : int = 800

var health : int = 100
var max_health : int = 100

var selected_weapon_id : int = 0

func _ready():
	weapon_manager.owned_weapons = inventory

func pickup(item_id):
	weapon_manager.owned_weapons[item_id]+=1

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

func hit(damage: int):
	health -= damage
	health_bar.update_heathbar(health)
	if health <= 0:
		on_death()

func on_death():
	queue_free()
	get_tree().root.get_child(0).reload_level()

func _physics_process(delta):

	collision_shape.rotation = gravity_manager.get_angle()
	sprite.rotation = gravity_manager.get_angle()
	
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
	
	velocity = velocity.move_toward(
		Vector2(input_vector.normalized().x * horizontal_speed, velocity.y).rotated(gravity_manager.get_angle()), delta * acceleration)
	
	velocity -= gravity_manager.gravity * delta;
	
	velocity = move_and_slide(velocity, gravity_manager.gravity.normalized())
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("item"):
			weapon_manager.owned_weapons[collision.collider.item_id]+=1
			collision.collider.queue_free()
		elif collision.collider.is_in_group("portal"):
			get_tree().root.get_child(0).next_level()
	
	if is_on_floor() && input_vector.y != 0:
		velocity += jump_strength * gravity_manager.gravity.normalized()

extends KinematicBody2D

onready var health_bar = $HeathBar
onready var weapons_manager = get_parent().get_node("Player").get_node("WeaponsManager")
onready var item : PackedScene = load("res://Assets/Scenes/Item.tscn")

export (float) var fire_rate = 0.3
export (int) var health
export (int) var speed
export (int) var weapon_id

var time_elapsed : float = 0
	
func hit(damage: int):
	health -= damage
	
	if health <= 0:
		on_death()
	
	health_bar.update_heathbar(health)
	
func on_death():
	var i = item.instance()
	print()
	owner.add_child(i)
	i.transform = transform
	i.set_item(weapon_id)
	print(owner.name)
	queue_free()

	#b.set_item(weapon_id)
	
func fire():
	var w = weapons_manager.weapons[weapon_id].instance()
	var p = owner.get_node("Player").position
	owner.add_child(w)
	w.target = p - position
	w.set_collision_mask_bit(2, false)
	w.set_collision_mask_bit(1, true)
	w.transform = transform

	
func _process(delta):
	time_elapsed += delta
	if time_elapsed >= fire_rate:
		fire()
		time_elapsed = 0

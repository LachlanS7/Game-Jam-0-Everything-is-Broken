extends KinematicBody2D

onready var health_bar = $HeathBar
onready var item : PackedScene = load("res://Assets/Scenes/Item.tscn")

export (int) var health
export (int) var speed
export (int) var weapon_id
	
func hit(damage : int):
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
	
	

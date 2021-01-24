extends KinematicBody2D

onready var health_bar = $HeathBar
onready var item : PackedScene = preload("res://Assets/Scenes/Item.tscn")

export (int) var health
export (int) var speed
export (int) var weapon_id
	
func hit(damage : int):
	health -= damage
	
	if health <= 0:
		on_death()
		queue_free()
	
	health_bar.update_heathbar(health)
	
func on_death():
	var i = item.instance()
	i.set_item(weapon_id)
	owner.add_child(i)
	i.get_node("Sprite").texture = owner.get_node("Player").get_node("WeaponsManager").weapons[weapon_id].instance().texture

	#b.set_item(weapon_id)
	
	

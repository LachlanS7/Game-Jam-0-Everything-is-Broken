extends Node2D

onready var sprite = $Sprite

var item_id : int

func set_item(id: int):
	item_id = id
	
	var thing = get_parent().get_node("Player").get_node("WeaponsManager").weapons[id]
	
	sprite.texture = thing.instance().get_node("Sprite").texture
	#get_node("Sprite")

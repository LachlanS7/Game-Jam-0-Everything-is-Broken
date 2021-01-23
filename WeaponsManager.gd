extends Node2D

onready var player = owner.get_node("Player")
onready var icon = player.get_node("WeaponIcon")

export (Array, PackedScene) var weapons

var owned_weapons = [2, 5]

func equip_weapon(id : int):
	icon.get_node("Sprite").texture = weapons[id].instance().get_node("Sprite").texture

func attack(weapon_id: int, target: Vector2):
	if weapons[weapon_id] && owned_weapons[weapon_id] > 0:			
		var w = weapons[weapon_id].instance()
		owner.add_child(w)
		w.transform = player.transform
		w.set("target", target)
		owned_weapons[weapon_id]-=1
		
func _ready():
	equip_weapon(0)

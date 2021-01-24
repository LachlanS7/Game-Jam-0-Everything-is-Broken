extends TextureProgress

var bar_red = preload("res://Assets/Textures/heathBarRed.png")
var bar_yellow = preload("res://Assets/Textures/heathBarYellow.png")
var bar_green = preload("res://Assets/Textures/heathBarGreen.png")

func _ready():
	if owner.health:
		max_value = owner.health

func update_heathbar(health : int):
	texture_progress = bar_green
	if health < max_value * 0.7:
		texture_progress = bar_yellow
	if health < max_value * 0.35:
		texture_progress = bar_red
	if health < max_value:
		show()
	value = health
	

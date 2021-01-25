extends Node2D

export (Array, PackedScene) var levels

var current_level = 0

func _ready():
	var t = levels[0].instance()
	var p = t.duplicate()
	t.queue_free()
	add_child(p)
			
func load_level(level: int):
	get_child(0).queue_free()
	var t = levels[level].instance()
	var p = t.duplicate()
	t.queue_free()
	add_child(p)
	
func next_level():
	current_level+=1
	load_level(current_level)

func reload_level():
	load_level(current_level)

func _input(event):
	if event.is_action_pressed("reload_level"):
		reload_level()
	

extends Node2D

export var gravity = Vector2(0, -1400)

func get_angle():
	return atan2(gravity.x, -gravity.y) 

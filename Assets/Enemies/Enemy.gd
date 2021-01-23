extends KinematicBody2D

export var health : int
	
func hit(damage : int):
	health -= damage
	
	if health <= 0:
		queue_free()

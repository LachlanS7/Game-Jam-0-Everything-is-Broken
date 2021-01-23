extends KinematicBody2D

export var health : int
#export () var weapon 	
	
func hit(damage : int):
	health -= damage
	
	if health <= 0:
		queue_free()

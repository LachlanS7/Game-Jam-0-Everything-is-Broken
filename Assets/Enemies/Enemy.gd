extends KinematicBody2D

export (int) var health
export (int) var speed

#export () var weapon 	
	
func hit(damage : int):
	health -= damage
	
	if health <= 0:
		queue_free()

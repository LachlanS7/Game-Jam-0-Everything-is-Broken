extends KinematicBody2D

onready var health_bar = $HeathBar

export (int) var health
export (int) var max_health
export (int) var speed

#export () var weapon 	
	
func hit(damage : int):
	health -= damage
	
	if health <= 0:
		queue_free()
	
	health_bar.update_heathbar(health)
	


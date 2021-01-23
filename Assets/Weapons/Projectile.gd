extends KinematicBody2D

export var target : Vector2 = Vector2.ZERO
export var bounces: int = 200
export var damage : int

var velocity : Vector2 = Vector2.ZERO
var speed: int = 2000

func _physics_process(delta):
	velocity = target.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(damage)
		if bounces == 0:
			self.queue_free()
		else:
			target = velocity.bounce(collision.normal)
			bounces-=1

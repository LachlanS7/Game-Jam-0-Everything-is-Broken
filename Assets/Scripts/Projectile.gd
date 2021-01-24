extends KinematicBody2D

export var bounces: int
export var damage : int
export var speed: int

var velocity : Vector2 = Vector2.ZERO
var target : Vector2 = Vector2.ZERO

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

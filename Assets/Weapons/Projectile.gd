extends Area2D

var velocity : Vector2 = Vector2.ZERO
export var target : Vector2 = Vector2.ZERO
var speed: int = 50
var bounces: int = 0

func _physics_process(delta):
	
	velocity = target.normalized() * speed
	position += velocity * delta
	

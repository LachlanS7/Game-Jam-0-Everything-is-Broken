extends Sprite

var y_position: float = 0
var time : float = 0

func _process(delta):
	time += delta
	y_position = sin(time * 5)
	transform.origin.y = 2.5 * y_position

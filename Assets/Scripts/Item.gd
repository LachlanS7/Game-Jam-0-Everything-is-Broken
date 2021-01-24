extends KinematicBody2D

onready var sprite = $Sprite
onready var gravity_manager = get_parent().get_node("GravityManager")

var item_id : int
var velocity : Vector2 = Vector2.ZERO

func _ready():
	add_to_group("item")

func set_item(id: int):
	item_id = id
	
	var thing = get_parent().get_node("Player").get_node("WeaponsManager").weapons[id]
	
	sprite.texture = thing.instance().get_node("Sprite").texture
	
	var shape = RectangleShape2D.new()
	shape.set_extents(sprite.texture.get_size() * 0.5)
	
	var collision = CollisionShape2D.new()
	collision.set_shape(shape)

	add_child(collision)
	
func _physics_process(delta):
	
	velocity -= gravity_manager.gravity * delta;
	velocity = move_and_slide(velocity, gravity_manager.gravity.normalized())

extends HP_Object

export var direction: Vector2 = Vector2(0,0)
export var movement_speed: int = 10

func _ready():
	if direction == Vector2(0,0):
		direction = Vector2(rand_range(-5,5),rand_range(-5,5)).normalized()

func _process(_delta):
	self.rotate(-0.3)
	
	# warning-ignore:return_value_discarded
	var collision = move_and_collide(direction*movement_speed)

	if collision != null:

		if collision.collider.name == "Player":
			var temp_node = collision.collider  
			temp_node.hp -= dmg

		direction = (direction.reflect(collision.normal)+collision.normal).normalized()

		



		

	

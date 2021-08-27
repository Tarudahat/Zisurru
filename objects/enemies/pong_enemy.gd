extends Enemy_Object

export var direction: Vector2 = Vector2(0,0)

func _ready():
	if direction == Vector2(0,0):
		direction = Vector2(rand_range(-5,5),rand_range(-5,5)).normalized()

func _process(_delta):
	self.rotate(-0.3)
	
	# warning-ignore:return_value_discarded
	collision = move_and_collide(direction*movement_speed)

	if collision != null:

		direction = (direction.reflect(collision.normal)+collision.normal).normalized()

		



		

	

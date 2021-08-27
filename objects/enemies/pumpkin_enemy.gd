extends Enemy_Object

func _process(_delta):
	collision = move_and_collide((Globals.player_refrence.position-position).normalized()*movement_speed)

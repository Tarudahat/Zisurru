extends PathFollow2D

onready var spike_body = get_node("static_spicky")

func _process(_delta):
	offset += 2.5

#makes sure the kinematicbody2d doesn't get pushed around by the player
func _physics_process(_delta):
	if spike_body.position != Vector2(0,0):
		spike_body.position = Vector2(0,0)
	

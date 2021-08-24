extends Popup

onready var clean_node = get_node("summoning_circle").duplicate()

func reset_summoning_circle():
	get_child(0).queue_free()
	add_child(clean_node.duplicate())

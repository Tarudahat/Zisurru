extends KinematicBody2D


var target_position: Vector2
var movement_speed = 7
var dmg = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	#find nearest node
	var level_objects = Globals.player_refrence.get_parent().get_children()
	#give a huge distance to start so that it won't take the player as it's target
	var closest_distance = 9999999999

	for node in level_objects:
		if node != Globals.player_refrence and node != self and node is Enemy_Object:
			if position.distance_to(node.position) < closest_distance:
				closest_distance = position.distance_to(node.position)
				target_position = node.position



func _process(_delta):
	look_at(target_position)
	var collision = move_and_collide((target_position-position).normalized()*movement_speed)

	if collision != null and collision.collider.name != "Player":
		if collision.collider is TileMap:
			queue_free()
		elif collision.collider.hp != null:
			var temp_node = collision.collider
			temp_node.hp -= dmg
			queue_free()

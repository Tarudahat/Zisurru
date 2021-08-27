extends BobbingItem

export var heal_value = 10

func _on_Area2D_body_entered(body):

	if !body is TileMap:
		if body.name == "Player":
			body.hp += heal_value
			queue_free()

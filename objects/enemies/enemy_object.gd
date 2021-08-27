class_name Enemy_Object
extends HP_Object

export var movement_speed: int = 10
export var dmg:int = 15
var collision

func _process(_delta):
	
	if collision != null:
		
		if collision.collider.name == "Player":
				var temp_node = collision.collider  
				temp_node.hp -= dmg

extends Area2D

var bodies_inside = []
var suction_strength = 125
export var spell_dmg = 25
onready var sprite = get_node("Sprite")
onready var timer = get_node("Timer")
var prev_time

func fade_away():
	queue_free()

func _process(_delta):
	sprite.rotate(-0.3)
	
	#pull in bodies
	for body in bodies_inside:
			body.move_and_slide((position-body.position).normalized()*suction_strength)
			if prev_time != round(timer.time_left):
				body.hp -= spell_dmg
		
	prev_time = round(timer.time_left)


func _on_Area2D_body_entered(body):
	if body is HP_Object and body.name != "Player":
		bodies_inside.append(body)


func _on_Area2D_body_exited(body):
	if body is HP_Object and body.name != "Player":
		bodies_inside.erase(body)


func _on_Timer_timeout():
	fade_away()

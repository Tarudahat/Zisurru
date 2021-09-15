extends Enemy_Object

var can_dmg_player: bool = false
var prev_sec = OS.get_system_time_secs()
var grab_strength = 200
var start_position

func _ready():
	start_position = position

func _process(_delta):
	position = start_position
	if can_dmg_player:
		Globals.player_refrence.move_and_slide((position-Globals.player_refrence.position).normalized()*grab_strength)
		if prev_sec != OS.get_system_time_secs():
			Globals.player_refrence.hp -= dmg
		
	prev_sec = OS.get_system_time_secs()

func _on_Area2D_body_entered(body):
	if Globals.player_refrence == body:
		can_dmg_player = true


func _on_Area2D_body_exited(body):
	if Globals.player_refrence == body:
		can_dmg_player = false

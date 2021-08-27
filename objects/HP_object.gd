class_name HP_Object
extends KinematicBody2D

export var hp:int = 100
export var disappear_on_death:bool = true
export var knock_back:bool = false

var max_hp:int = hp

#used for checking if any dmg has been taken
var prev_hp:int = hp
var knock_back_timer:int = 0

func _process(_delta):
	#cap hp
	if hp > max_hp:
		hp = max_hp
	if hp <= 0:
		hp=0
	#knock-back stuff
	if knock_back_timer >= OS.get_system_time_secs():
		hp = prev_hp

	if prev_hp > hp and knock_back:
		print("got hit")
		#bad code VVVVV 
		get_child(1).emitting = true
		
		knock_back_timer = OS.get_system_time_secs()+1

	if hp <= 0 and disappear_on_death:
		queue_free()

	prev_hp = hp

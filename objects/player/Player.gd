extends KinematicBody2D

export var movement_speed:int = 225
var velocity:Vector2 = Vector2()
var move_to_point:bool = false
var summoning_circle_popup = GlobalCanvasLayer.get_node("summon_popup")

func _process(_delta):
	velocity = Vector2()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		move_to_point = true
		velocity =  get_local_mouse_position().normalized()*movement_speed
	
	if Input.is_action_just_pressed("in_cast_spell"):
		if summoning_circle_popup.visible:
			summoning_circle_popup.visible=false
		else: 
			summoning_circle_popup.reset_summoning_circle()
			summoning_circle_popup.popup()

	velocity = move_and_slide(velocity)

extends HP_Object

export var movement_speed:int = 250
var velocity:Vector2 = Vector2()
var move_to_point:bool = false
onready var player_ui = get_node("player_ui/player_ui")
onready var summoning_circle_popup = player_ui.get_node("summon_popup")
onready var hp_bar = player_ui.get_node("hp_bar")
onready var animated_sprite = get_node("AnimatedSprite")

func _ready():
	player_ui.visible=true
	hp_bar.max_value = hp

func _process(_delta):
	velocity = Vector2()

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		move_to_point = true
		velocity =  get_local_mouse_position().normalized()*movement_speed
		
		if get_local_mouse_position().x > 0:
			animated_sprite.flip_h=false
		else:
			animated_sprite.flip_h=true
			
	if Input.is_action_just_pressed("in_cast_spell"):
		if summoning_circle_popup.visible:
			summoning_circle_popup.visible=false
		else: 
			summoning_circle_popup.reset_summoning_circle()
			summoning_circle_popup.popup()

	velocity = move_and_slide(velocity)

	hp_bar.value = hp


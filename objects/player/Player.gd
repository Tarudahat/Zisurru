extends HP_Object

export var movement_speed:int = 225
var velocity:Vector2 = Vector2()
var move_to_point:bool = false
onready var player_ui = get_node("player_ui/player_ui")
onready var hp_bar = player_ui.get_node("hp_bar")
onready var animated_sprite = get_node("AnimatedSprite")
var collision
var gem = {"gem_type":"","effect_path":"","amount":0,"color":0}
var inventory = {"inventory":
				[{"gems":[]}
				,{"skins":[]}]}


func _ready():
	Globals.player_refrence = self
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

	velocity = move_and_slide(velocity)
	
	hp_bar.value = hp


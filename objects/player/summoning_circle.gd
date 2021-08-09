extends Control


var draw_order = PoolVector2Array()
var spell_draw_orders=[]

export var dev_mode:bool
export var drawing_color:Color
# @export var drawing_color:Color GD 4.0 when?

var first_button

var json_data = {"spells":[]}

var json_spell= {
	"name":"",
	"rank":"",
	"cost":0,
	"draw_order":[],
}

#needed for checking differences between the current item and the last one
var pressed_order = []
var prev_pressed = []
var prev_line = Vector2()
var prev_button 

func _ready():
	#load spells
	var directory = Directory.new()
	if directory.file_exists(JsonHandler.file_path):
		json_data = JsonHandler.load_dictionary()

	for spell in json_data["spells"]:
		var temp_draw_order = PoolVector2Array()
		for item in spell["draw_order"]:
			temp_draw_order.append(JsonHandler.deserialize_vector(item))
		spell_draw_orders.append(temp_draw_order)

	print(spell_draw_orders)


func _process(_delta):
	var current_pressed = []
	var i = 0

	#havn't touched coding since months so it has gone completly trash :|
	for button in get_child(0).get_children():
		current_pressed.append(button.pressed)
		
		if pressed_order.size()==1:
				first_button=pressed_order[0]
				
		if (prev_pressed.size()>0) and (prev_pressed[i]!=button.pressed):

			pressed_order.append(button)
			if prev_button!=null:
				if prev_button.rect_position!=button.rect_position:

					var line = Line2D.new()
					var line_points = PoolVector2Array([prev_button.rect_position+Vector2(18,18),button.rect_position+Vector2(18,18)])
					line.points = line_points
					line.default_color = Color(drawing_color)
					line.width = 4
					add_child(line)
					if prev_line.normalized() != (line_points[0]-line_points[1]).normalized():
						#save line if it's not an extension of the previous line
						draw_order.append((line_points[0]-line_points[1]))
					else:
						#it's an extension so make the last line extended
						draw_order[draw_order.size()-1] *= 2
						
					prev_line = (line_points[0]-line_points[1])
					
			
					if pressed_order.size()>=2:
						if (pressed_order[pressed_order.size()-1]==first_button):
							print("spell complete???")
							if draw_order in spell_draw_orders:
								print("valid spell!!!")
								for index in range(spell_draw_orders.size()):
									if spell_draw_orders[index]==draw_order:
										print(json_data["spells"][index]["name"])
		
			prev_button = button

		i += 1
		
	prev_pressed = current_pressed

	if dev_mode:
		$dev.visible = true

		#save new spell
		if Input.is_action_just_pressed("in_save"):
			var temp_json_spell = json_spell.duplicate()

			temp_json_spell["name"] = $dev/dev_spell_name.text
			temp_json_spell["cost"] = str2var($dev/dev_spell_cost.text)
			temp_json_spell["rank"] = Globals.SPELL_CLASSES[$dev/dev_spell_class.selected]

			for item in draw_order:
				temp_json_spell["draw_order"].append(JsonHandler.serialize_vector(item))

			json_data["spells"].append(temp_json_spell)

			JsonHandler.save_dictionary(json_data)
			get_parent().reset_summoning_circle()

extends HBoxContainer

var pos = "1ST" setget set_posi
var name = "AAA" setget set_name
var score = "999" setget set_score
var color = Color(1,1,1,1) setget set_colors

func set_posi(val):
	pos = val
	get_node("Pos").set_text(str(val))
	
func set_name(val):
	name = val
	get_node("Name").set_text(str(val))

func set_score(val):
	score = val
	get_node("Score").set_text(str(val))

func set_colors(val):
	color = val
	
	get_node("Pos").set("custom_colors/font_color", color)
	get_node("Name").set("custom_colors/font_color", color)
	get_node("Score").set("custom_colors/font_color", color)

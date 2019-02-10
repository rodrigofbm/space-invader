extends VBoxContainer

var score_item_scn = preload("res://Scenes/ScoreItem.tscn")

var positions = ["1ST", "2ST", "3ST", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH",]
var colors = ["ff0000", "ff7700", "ffb900", "fdff00", "c7ff00", "49ff00", "00ff5d", "00fff3", "008dff", "0700ff",]

func _ready():
	pass
	#teste()
	
func teste():
	for a in range(10):
		var score_item = score_item_scn.instance()
		score_item.set_posi(positions[a])
		add_child(score_item)
		get_node("Timer").start()
		yield(get_node("Timer"), "timeout")
		
func show_high_score(high_scores):
	for c in get_children():
		if c extends HBoxContainer:
			c.queue_free()
	
	var a = 0
	for hs in high_scores:
		var score_item = score_item_scn.instance()
		score_item.set_posi(positions[a])
		score_item.set_name(hs.name)
		score_item.set_score(hs.score)
		score_item.set_colors(colors[a])
		add_child(score_item)
		get_node("Timer").start()
		yield(get_node("Timer"), "timeout")
		a += 1
	pass

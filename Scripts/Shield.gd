extends Area2D

var hits = 0

func _ready():
	pass

func destroy(obj):
	hits += 1
	
	if hits > 5:
		queue_free()
	
	get_node("Sprite").set_frame(hits)
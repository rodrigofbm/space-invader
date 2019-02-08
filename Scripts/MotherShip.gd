extends Area2D

var score = 200

signal destroyed(obj)

func _ready():
	get_node("SamplePlayer").play("mother_ship")
	get_node("Anim").play("default")
	yield(get_node("Anim"), "finished")
	queue_free()

func destroy(obj):
	emit_signal("destroyed", self)
	queue_free()
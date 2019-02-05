extends Node2D


func _ready():
	get_node("Anim").play("AlienXplosion")
	#aguarde o singal finished do node anim
	yield(get_node("Anim"), "finished")
	queue_free()
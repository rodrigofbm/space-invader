extends Area2D

const VEL = 150
var dir = Vector2(0, 1)

func _ready():
	set_process(true)

func _process(delta):
	translate(dir * VEL * delta)
	if get_global_pos().y > 320:
		destroy(self)
	
func destroy(obj):
	queue_free()

func _on_AlienShoot_area_enter( area ):
	if area.has_method("destroy"):
		area.destroy(self)
		destroy(self)

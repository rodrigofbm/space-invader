extends Area2D

const VEL = 250
var dir = Vector2(0, -1)

func _ready():
	add_to_group("shoot_group")
	set_process(true)
	
func _process(delta):
	translate(dir * VEL * delta)
	if(get_global_pos().y < 0):
		queue_free()

func _on_Laser_area_enter( area ):
	if area.has_method("destroy"):
		area.destroy(self)
		destroy(self)
		
func destroy(obj):
	queue_free()
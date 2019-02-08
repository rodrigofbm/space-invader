extends Area2D

const VEL = 80

var laserSCN = preload("res://Scenes/Laser.tscn")

var left
var right
var dir = 0
var laser
var press_laser = false
var is_alive = true

signal destroyed(obj)
signal respawn(obj)

func _ready():
	set_process(true)

func _process(delta):
	var dir = 0
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	laser = Input.is_action_pressed("Shoot")
	
	if(right):
		dir += 1
	if(left):
		dir -= 1
	translate(Vector2(1,0) * VEL * dir * delta)

	#limitar movimento
	if get_global_pos().x <= 7.5:
		set_global_pos(Vector2(7.5, get_global_pos().y))
	if get_global_pos().x >= 172.5:
		set_global_pos(Vector2(172.5, get_global_pos().y))
	
	#limitar tiros; not press_laser serve para n atirar pressionado o botao shoot
	if(laser and not press_laser and get_tree().get_nodes_in_group("shoot_group").size() < 1000):
		var shoot = laserSCN.instance()

		get_parent().add_child(shoot)
		shoot.set_global_pos(get_global_pos())
		get_node("SamplePlayer").play("ship_shoot")
	
	press_laser = laser
	
func disable():
	hide()
	set_process(false)
	is_alive = false

func destroy(obj):
	if is_alive:
		get_node("SamplePlayer").play("ship_explosion")
		is_alive = false
		set_process(false)
		emit_signal("destroyed")
		get_node("Anim").play("xplosion")
		yield(get_node("Anim"), "finished")
		emit_signal("respawn")
		set_process(true)
		is_alive = true
		get_node("Sprite").set_frame(0)
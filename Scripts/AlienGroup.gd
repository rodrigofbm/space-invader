extends Node2D

var alienShoot = preload("res://Scenes/AlienShoot.tscn")
var alienXplosion = preload("res://Scenes/AlienXplosion.tscn")
const dir = Vector2(1, 0) * 6
var sentido = 1

func _ready():
	get_node("TimerShoot").start()
	for alien in get_node("aliens").get_children():
		alien.connect("destroyed", self, "on_alien_destroyed")


func shoot():
	var n_aliens = get_node("aliens").get_child_count()
	var alien = get_node("aliens").get_child(randi() % n_aliens)
	var alien_shoot = alienShoot.instance()
	get_parent().add_child(alien_shoot)
	alien_shoot.set_global_pos(alien.get_global_pos())

func _on_TimerShoot_timeout():
	get_node("TimerShoot").set_wait_time(rand_range(0.5, 3))
	shoot()


func _on_TimerMove_timeout():
	var border = false
	
	for alien in get_node("aliens").get_children():
		alien.next_frame()

		if alien.get_global_pos().x > 172.5 and sentido > 0:
			sentido = -1
			border = true
		if alien.get_global_pos().x <= 7.5 and sentido < 0:
			sentido = 1
			border = true

	if border:
		translate(Vector2(0, 8))
		if get_node("TimerMove").get_wait_time() >= 0.1:
			get_node("TimerMove").set_wait_time(get_node("TimerMove").get_wait_time() - 0.1)
	else:
		translate(dir * sentido)

func on_alien_destroyed(alien):
	var alien_exp = alienXplosion.instance()
	get_parent().add_child(alien_exp)
	alien_exp.set_global_pos(alien.get_global_pos())
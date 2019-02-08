extends Node2D

const dir = Vector2(1, 0) * 6

var alienShoot = preload("res://Scenes/AlienShoot.tscn")
var alienXplosion = preload("res://Scenes/AlienXplosion.tscn")
var motherShip = preload("res://Scenes/MotherShip.tscn")

var sentido = 1
#shoot()
var n_aliens = 0
var alien
var alien_shoot

var note = 1;

signal enemy_down(obj)
signal earth_down(obj)
signal victory(obj)

func _ready():
	instance_mother_ship()
	get_node("TimerShoot").start()
	for alien in get_node("aliens").get_children():
		alien.hide()
		alien.connect("destroyed", self, "on_alien_destroyed")
	
	for alien in get_node("aliens").get_children():
		get_node("TimerDrawAlien").start()
		yield(get_node("TimerDrawAlien"), "timeout")
		alien.show()

func shoot():
	get_node("SamplePlayer").play("alien_shot")
	n_aliens = get_node("aliens").get_child_count()

	if n_aliens > 0:
		alien = get_node("aliens").get_child(randi() % n_aliens)
		alien_shoot = alienShoot.instance()
		get_parent().add_child(alien_shoot)
		alien_shoot.set_global_pos(alien.get_global_pos())

func _on_TimerShoot_timeout():
	get_node("TimerShoot").set_wait_time(rand_range(0.5, 3))
	shoot()


func _on_TimerMove_timeout():
	var border = false

	get_node("SamplePlayer").play(str(note))
	note += 1
	if note > 4:
		note = 1

	for alien in get_node("aliens").get_children():
		alien.next_frame()

		if alien.get_global_pos().x > 172.5 and sentido > 0:
			sentido = -1
			border = true
		if alien.get_global_pos().x <= 7.5 and sentido < 0:
			sentido = 1
			border = true
		
		if alien.get_global_pos().y > 278:
			emit_signal("earth_down", self)

	if border:
		translate(Vector2(0, 8))
		if get_node("TimerMove").get_wait_time() >= 0.1:
			get_node("TimerMove").set_wait_time(get_node("TimerMove").get_wait_time() - 0.1)
	else:
		translate(dir * sentido)

func on_alien_destroyed(alien):
	get_node("SamplePlayer").play("alien_explosion")
	emit_signal("enemy_down", alien)
	var alien_exp = alienXplosion.instance()

	get_parent().add_child(alien_exp)
	alien_exp.set_global_pos(alien.get_global_pos())

	if get_node("aliens").get_child_count() == 1:
		stop_all()
		emit_signal("victory")

func _on_TimerMotherShip_timeout():
	var mother_ship = motherShip.instance()
	mother_ship.connect("destroyed", self, "on_alien_destroyed")
	
	get_parent().add_child(mother_ship)
	#reinicia o timer
	instance_mother_ship()

func instance_mother_ship():
	var timerMS = get_node("TimerMotherShip")
	
	timerMS.set_wait_time(rand_range(3, 10))
	timerMS.start()

func stop_all():
	get_node("TimerShoot").stop()
	get_node("TimerMove").stop()
	get_node("TimerMotherShip").stop()

func start_all():
	get_node("TimerShoot").start()
	get_node("TimerMove").start()
	get_node("TimerMotherShip").start()
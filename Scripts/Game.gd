extends Node

const EXTRA_LIFE_POINT = [ 100, 200, 500 ]
signal game_over(obj)
signal victory(obj)



var data = {
	extra_life_index = 0,
	score = 0,
	lives = 3
} setget set_data

func _ready():
	randomize()
	update_score()
	get_node("Alien_Group").connect("enemy_down", self, "on_alien_group_enemy_down")
	get_node("Alien_Group").connect("earth_down", self, "on_alien_group_earth_down")
	get_node("Alien_Group").connect("victory", self, "on_alien_group_victory")
	get_node("Ship").connect("destroyed", self, "on_ship_destroyed")
	get_node("Ship").connect("respawn", self, "on_ship_respawn")

func on_alien_group_enemy_down(alien):
	data.score += alien.score
	if data.extra_life_index < EXTRA_LIFE_POINT.size() and data.score >= EXTRA_LIFE_POINT[data.extra_life_index]:
		data.lives += 1
		update_lives()
		data.extra_life_index +=1
	update_score()

func update_score():
	get_node("HUD/Score").set_text(str(data.score))

func update_lives():
		get_node("HUD/LifrDraw").set_lives(data.lives)

func update_hud():
	update_score()
	update_lives()

func on_ship_destroyed():
	get_node("Alien_Group").stop_all()
	data.lives -=1
	update_lives()
	get_tree().call_group(0,"alien_shoot", "destroy", self)
	
func on_ship_respawn():
	if data.lives <= 0:
		game_over()
	else:
		get_node("Alien_Group").start_all()

func on_alien_group_earth_down(obj):
	game_over()

func game_over():
	emit_signal("game_over")
	game_done()

func on_alien_group_victory():
	emit_signal("victory")
	game_done()

func game_done():
	get_node("Alien_Group").stop_all()
	get_node("Ship").disable()

func set_data(val):
	data = val
	update_hud()
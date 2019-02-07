extends Node

const EXTRA_LIFE_POINT = [ 100, 200, 500 ]

var extra_life_index = 0

var score = 0
var lives = 3

func _ready():
	randomize()
	update_score()
	get_node("Alien_Group").connect("enemy_down", self, "on_alien_group_enemy_down")
	get_node("Alien_Group").connect("earth_down", self, "on_alien_group_earth_down")
	get_node("Ship").connect("destroyed", self, "on_ship_destroyed")
	get_node("Ship").connect("respawn", self, "on_ship_respawn")

func on_alien_group_enemy_down(alien):
	score += alien.score
	if extra_life_index < EXTRA_LIFE_POINT.size() and score >= EXTRA_LIFE_POINT[extra_life_index]:
		lives += 1
		get_node("HUD/LifrDraw").set_lives(lives)
		extra_life_index +=1
	update_score()

func update_score():
	get_node("HUD/Score").set_text(str(score))

func on_ship_destroyed():
	get_node("Alien_Group").stop_all()
	lives -=1
	get_node("HUD/LifrDraw").set_lives(lives)
	get_tree().call_group(0,"alien_shoot", "destroy", self)
	
func on_ship_respawn():
	if lives <= 0:
		game_over()
	else:
		get_node("Alien_Group").start_all()

func on_alien_group_earth_down(obj):
	game_over()

func game_over():
	get_node("Alien_Group").stop_all()
	get_node("Ship").disable()
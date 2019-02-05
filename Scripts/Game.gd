extends Node

var score = 0

func _ready():
	update_score()
	get_node("Alien_Group").connect("enemy_down", self, "on_alien_group_enemy_down")

func on_alien_group_enemy_down(alien):
	score += alien.score
	update_score()

func update_score():
	get_node("HUD/Score").set_text(str(score))
extends Node

var game_scn = preload("res://Scenes/Game.tscn")
var game

var data = {}

func _ready():
	pass

func new_game():
	if game != null:
		game.queue_free()

	game = game_scn.instance()
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_game_victory")
	add_child(game)

func _on_Button_pressed():
	get_node("btnNewGame").hide()
	new_game()

func on_game_over():
	get_node("btnNewGame").show()

func on_game_victory():
	data = game.data
	new_game()
	game.set_data(data)
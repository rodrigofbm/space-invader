extends Node

const high_score_file = "user://high_score_file"

var selector_name_scn = preload("res://Scenes/NameSelector.tscn")
var game_scn = preload("res://Scenes/Game.tscn")
var game

var data = {}
var high_scores = [
	{name = "AAA", score = 1000},
	{name = "BBB", score = 900},
	{name = "CCC", score = 800},
	{name = "DDD", score = 700},
	{name = "EEE", score = 600},
	{name = "FFF", score = 500},
	{name = "GGG", score = 400},
	{name = "HHH", score = 300},
	{name = "III", score = 200},
	{name = "JJJ", score = 100},
]
var high_score

func _ready():
	load_high_score()
	get_node("HighScore").show_high_score(high_scores)
	pass

func new_game():
	if game != null:
		game.queue_free()

	game = game_scn.instance()
	game.connect("game_over", self, "on_game_over")
	game.connect("victory", self, "on_game_victory")
	get_node("GameNode").add_child(game)

func _on_Button_pressed():
	get_node("HighScore").hide()
	get_node("btnNewGame").hide()
	get_node("CustomShader").hide()
	new_game()

func on_game_over():
	high_score = null
	for hs in high_scores:
		if game.data.score > hs.score:
			high_score = hs
			break
	
	if high_score != null:
		var selector_name = selector_name_scn.instance()
		add_child(selector_name)
		selector_name.connect("name_typed", self, "on_name_selector_name_typed")
		#esperar pelo sinal ser enviado para continuar o código
		yield(selector_name, "name_typed")
		selector_name.queue_free()
		save_high_score()
	
	get_node("HighScore").show()
	get_node("HighScore").show_high_score(high_scores)
	get_node("CustomShader").show()
	get_node("btnNewGame").show()

func on_game_victory():
	data = game.data
	new_game()
	game.set_data(data)

func on_name_selector_name_typed(val):
	var index = high_scores.find(high_score)
	high_scores.insert(index, {name = val, score = game.data.score})
	high_scores.resize(10)
	print(high_scores)
	
func save_high_score():
	var file = File.new()
	var result = file.open(high_score_file, file.WRITE)
	
	if result == OK:
		var store_high_score = { highscores = high_scores}
		file.store_string(store_high_score.to_json())
		file.close()
		
func load_high_score():
	var file = File.new()
	var result = file.open(high_score_file, file.READ)
	
	if result == OK:
		var text = file.get_as_text()
		var store_high_score = {}
		store_high_score.parse_json(text)
		high_scores = store_high_score.highscores
		file.close()
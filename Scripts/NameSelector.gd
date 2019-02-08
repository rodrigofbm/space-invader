extends Node

const LETTERS = "ABCDEFGHIJKLMNOPQRSTUVXWYZ0123456789_*# "

var index  = 0
var letter = 0
var alterou = false

signal name_typed(name)

func _ready():
	set_process_input(true)

func _input(event):
	alterou = false
	if event.is_action_pressed("ui_right") and !event.is_echo():
		index += 1
		alterou = true

	if event.is_action_pressed("ui_left") and !event.is_echo():
		index -= 1
		alterou = true

	if alterou:
		if index < 0:
			index = LETTERS.length() - 1
		elif index >= LETTERS.length():
			index = 0
		get_node("Container").get_child(letter).set_text(LETTERS[index])

	if event.is_action_pressed("Shoot") and !event.is_echo():
		index = 0
		get_node("Container").get_child(letter).set_opacity(1)
		letter += 1
		if letter > 2:
			get_node("Timer").stop()
			set_process_input(false)
			var name = get_node("Container").get_child(0).get_text() + get_node("Container").get_child(1).get_text() + get_node("Container").get_child(2).get_text()
			emit_signal("name_typed", name)

func _on_Timer_timeout():
	if get_node("Container").get_child(letter).get_opacity() > 0:
		get_node("Container").get_child(letter).set_opacity(0)
	else:
		get_node("Container").get_child(letter).set_opacity(1)

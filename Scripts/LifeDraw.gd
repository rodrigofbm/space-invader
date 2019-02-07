tool
extends Node2D

export(Texture) var textura
export(int) var lives = 3 setget set_lives

func _ready():
	pass

func _draw():
	for l in range(lives):
		draw_texture_rect_region(textura, Rect2(l*16, 1, 15, 8), Rect2(0,0,15,8), Color(1,1,1,1), false)

func set_lives(value):
	lives = value
	update()
extends Node2D

onready var fruits = get_node("Fruits")

var pineapple = preload("res://scenes//Ninja/pineapple.tscn")
var pear = preload("res://scenes//Ninja/pear.tscn")
var orange = preload("res://scenes//Ninja/orange.tscn")
var watermelon = preload("res://scenes//Ninja/watermelon.tscn")
var bomb = preload("res://scenes//Ninja/bomb.tscn")

var score = 0
var life = 3

func _ready():
	pass

func _on_Generator_timeout():
	if (life <= 0): return
	for i in range(0,rand_range(1,4)):
		var type = int(rand_range(0,5))
		var obj
		if type == 0:
			obj = pineapple.instance()
		elif type == 1:
			obj = pear.instance()
		elif type == 2:
			obj = orange.instance()
		elif type == 3:
			obj = watermelon.instance()
		elif type == 4:
			obj = bomb.instance()
		obj.born(Vector2(rand_range(200,1080), 800))
		obj.connect("life", self, "dec_life")
		if (type != 4):
			obj.connect("score", self, "inc_score")
		fruits.add_child(obj)

func dec_life():
	life -= 1
	if (life == 0):
		get_node("InputProc").acabou = true
		get_node("Control/Bomb1").set_modulate(Color(1,0,0))
		get_node("GameOverScreen").start()
	if (life == 2):
		get_node("Control/Bomb3").set_modulate(Color(1,0,0))
	if (life == 1):
		get_node("Control/Bomb2").set_modulate(Color(1,0,0))

func inc_score():
	if (life == 0): return
	score += 1
	get_node("Control/Label").set_text(str(score))
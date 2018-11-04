extends Node2D

onready var felpudo = get_node("Felpudo")
onready var timeReplay = get_node("TimeToReplay")
onready var lable = get_node("Node2D/Control/Label")
var pontos = 0
var estado = 1
const JOGANDO = 1
const PERDENDO = 2

func _ready():
	pass

func kill():
	felpudo.apply_impulse(Vector2(0,0), Vector2(-1000,0))
	get_node("BackAnim").stop()
	estado = PERDENDO
	timeReplay.start()
	get_node("SomHit").play()

func _on_TimeToReplay_timeout():
	get_tree().reload_current_scene()

func pontuar():
	pontos += 1
	lable.set_text(str(pontos))
	get_node("SomScore").play()
	
extends AnimatedSprite
# Posição discreta
var posdisc
# Direção
var dir
#Destino discreto
var destdisc
#destcont
var destcont

var speed
var dead

var pacman_center = Vector2(16,16)


signal pac

onready var tiles = get_parent().get_node("TileMap")



func _ready():
	spawn()
	set_process(true)
	pass

func spawn():
	# posicao discreta de inicio
	posdisc = Vector2(9, 15)
	# considera centro do pacman
	set_pos(posdisc * 32 + pacman_center)
	
	dir = Vector2(0, 0)
	destdisc = posdisc
	destcont = get_pos()
	
	speed = 150
	dead = false
	
	set_scale(Vector2(0.4, 0.4))
	set_flip_h(true)
	set_rotd(0)

func _process(delta):
	if dead: return
	var delcont = destcont - get_pos()
	if delcont != Vector2(0, 0):
		#Chegou no lugar
		if delcont.length() < 2:
			set_pos(destdisc*32 + pacman_center)
			posdisc = destdisc
			
			# Comer
			if tiles.get_cell(posdisc.x, posdisc.y) == 1:
				#Faz a celula ficar vazia
				tiles.set_cell(posdisc.x, posdisc.y, -1)
				get_node("../../Hud").add_score(10)
			if tiles.get_cell(posdisc.x, posdisc.y) == 2:
				#Faz a celula ficar vazia
				tiles.set_cell(posdisc.x, posdisc.y, -1)
				get_node("../../Hud").add_score(20)
				emit_signal("pac", "spec")
				
		else:
			set_pos(get_pos() + delta * speed * delcont.normalized())
			
	else:
		
		if dir != Vector2(0,0):
			var destdiscaux = posdisc + dir
			if destdiscaux == Vector2(19,9):
				# Teletransporte pro outro lado do mapa
				destdiscaux = Vector2(0, 9)
				set_pos(Vector2(-1, 9)*32 + pacman_center)
			elif destdiscaux == Vector2(-1, 9):
				destdiscaux = Vector2(18, 9)
				set_pos(Vector2(19, 9)*32 + pacman_center)
			# Não pode entrar na parede nem onde os fantasmas nascem
			if (
				tiles.get_cell(destdiscaux.x, destdiscaux.y) != 0
				and destdiscaux != Vector2(9, 8)
				):
				destdisc = destdiscaux
				destcont = get_pos()+ 32 * dir
				emit_signal("pac", "move")
			
	dir = Vector2(0, 0)
	if Input.is_action_pressed("left"):
		dir = Vector2(-1, 0)
		set_flip_h(true)
		set_rotd(0)
	elif Input.is_action_pressed("right"):
		dir = Vector2(1, 0)
		set_flip_h(false)
		set_rotd(0)
	elif Input.is_action_pressed("up"):
		dir = Vector2(0, -1)
		set_flip_h(false)
		set_rotd(90)
	elif Input.is_action_pressed("down"):
		dir = Vector2(0, 1)
		set_flip_h(false)
		set_rotd(-90)
		
func _on_Area_area_enter( area ):
	if dead: return
	# Verifica estado do fantasma
	if area.get_parent().state == area.get_parent().NORMAL:
		# mata pacman
		dead = true
		get_node("DieAnim").play("Die")
		emit_signal("pac", "die")
		get_node("../../Hud").save_high()
		yield(get_node("DieAnim"), "finished")
		spawn()
		emit_signal("pac", "reset")
	elif area.get_parent().state == area.get_parent().BLUE:
		area.get_parent().respawn()
		get_node("../../Hud").add_score(200)

extends Node

var barril = preload("res://scenes/barril.tscn")
var barril_esquerda = preload("res://scenes/barril_esquerda.tscn")
var barril_direita = preload("res://scenes/barril_direita.tscn")

onready var felpudo = get_node("Felpudo")
onready var camera = get_node("Camera")
onready var barris = get_node("Barris")
onready var dest_barris = get_node("DestBarris")
onready var barra = get_node("Barra")
onready var label_pontos = get_node("Controle/Pontos")

var ultimo_inimido
var pontos = 0
var estado = JOGANDO

const JOGANDO = 1
const PERDEU = 2

func _ready():
	randomize()
	set_process_input(true)
	gerarBarrisIniciais()
	barra.connect("perdeu", self, "perder")
	
func _input(event):
	event = camera.make_input_local(event)
	
	if event.type == InputEvent.SCREEN_TOUCH && event.pressed and estado == JOGANDO:
		if event.pos.x < 360:
			felpudo.esquerda()
		else:
			felpudo.direita()
		
		if !verificaColisao():
			felpudo.bater()
			var primeiro_barril = barris.get_children()[0]
			barris.remove_child(primeiro_barril)
			dest_barris.add_child(primeiro_barril)
			primeiro_barril.destruir(felpudo.lado)
			aleaBarril(Vector2(360, 1090 - 10 * 172))
			descer()
			
			barra.add(0.014)
			
			pontos += 1
			label_pontos.set_text(str(pontos))
			
			if verificaColisao():
				perder()
		else:
			perder()

func aleaBarril(pos):
	var numero = rand_range(0, 3)
	
	if ultimo_inimido: 
		numero = 0
	
	gerarBarril(int(numero), pos)

func gerarBarril(tipo, posicao):
	var novo_barril
	
	if tipo == 0:
		novo_barril = barril.instance();
		ultimo_inimido = false
	elif tipo == 1:
		novo_barril = barril_direita.instance()
		ultimo_inimido = true
		novo_barril.add_to_group("BarrilDireita")
	elif tipo == 2:
		novo_barril = barril_esquerda.instance()
		ultimo_inimido = true
		novo_barril.add_to_group("BarrilEsquerda")
	
	novo_barril.set_pos(posicao)
	barris.add_child(novo_barril)

func gerarBarrisIniciais():
	for i in range(0, 3):
		gerarBarril(0, Vector2(360, 1090 - i * 172))
	
	for i in range(3, 10):
		aleaBarril(Vector2(360, 1090 - i * 172))
		

func verificaColisao():
	var lado = felpudo.lado
	var primeiro_barril = barris.get_children()[0]
	
	print("lado felpudo ", lado)
	printt("grupo barril: ", primeiro_barril.is_in_group("BarrilEsquerda"))
	if lado == felpudo.ESQUERDA and primeiro_barril.is_in_group("BarrilEsquerda"):
		return true
	if lado == felpudo.DIREITA and primeiro_barril.is_in_group("BarrilDireita"):
		return true
	
	return false

func descer():
	for b in barris.get_children():
		b.set_pos(b.get_pos() + Vector2(0, 172))

func perder():
	felpudo.morrer()
	barra.set_process(false)
	estado = PERDEU
	get_node("Timer").start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()
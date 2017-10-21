extends Node2D

enum { SEM_INIMIGO, INIMIGO_DIREITA, INIMIGO_ESQUERDA }

const ESQUERDA = -1

func _ready():
	pass

func destruir(sentido):
	if sentido == ESQUERDA:
		get_node("Anim").play("direita")
	else:
		get_node("Anim").play("esquerda")
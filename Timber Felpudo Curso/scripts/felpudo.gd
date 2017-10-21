extends Node2D

const ESQUERDA = -1
const DIREITA = 1

onready var idle = get_node("Idle")
onready var bate = get_node("Bate")
onready var grave = get_node("Grave")
onready var anim = get_node("Anim")

var lado

func _ready():
	pass

func esquerda():
	set_pos(Vector2(220, 1070))
	idle.set_flip_h(false)
	bate.set_flip_h(false)
	grave.set_pos(Vector2(-44 ,41))
	grave.set_flip_h(true)
	lado = ESQUERDA

func direita():
	set_pos(Vector2(500, 1070))
	idle.set_flip_h(true)
	bate.set_flip_h(true)
	grave.set_pos(Vector2(28 ,41))
	grave.set_flip_h(false)
	lado = DIREITA

func bater():
	anim.play("Bate")

func morrer():
	anim.stop()
	idle.hide()
	bate.hide()
	grave.show()
	
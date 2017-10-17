extends Node2D

const JOGANDO = 1
const PERDENDO = 2

onready var felpudo = get_node("Felpudo")
var back_anim
var timer_to_replay
var label_pontos
var som_score
var som_hit

var pontos = 0
var estado = 1

func _ready():
	back_anim = get_node("BackAnim")
	timer_to_replay = get_node("TimerToReplay")
	label_pontos = get_node("Node2D/Control/Label")
	som_score = get_node("SomScore")
	som_hit = get_node("SomHit")
	
func kill():
	felpudo.morrer()
	back_anim.stop()
	estado = PERDENDO
	timer_to_replay.start()
	som_hit.play()
	
func pontuar():
	pontos += 1
	label_pontos.set_text(str(pontos))
	som_score.play()

func _on_TimerToReplay_timeout():
	get_tree().reload_current_scene()

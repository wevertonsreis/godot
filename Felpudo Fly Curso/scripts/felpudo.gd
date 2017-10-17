extends RigidBody2D

const VIVO = 1
const MORTO = 2

var estado
var game_node
var som_voa

func _ready():
	estado = VIVO
	game_node = get_tree().get_current_scene();
	som_voa = get_node("SonVoa")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("touch"):
		voar()

func voar():
	if estado == VIVO:
		apply_impulse(Vector2(0 ,0), Vector2(0, -1000))
		som_voa.play()
	
func morrer():
	apply_impulse(Vector2(0, 0), Vector2(-1000,0))
	estado = MORTO
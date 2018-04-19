extends KinematicBody2D

const vel_x = 500
const grav = 1500

var velocity = Vector2(500, 0)
var jump = false
var jump_release = false
var was_on_floor = false
var controled_jump = false

onready var mask = collision_mask
onready var layer = collision_layer

enum {IDLE, RUNNIG, FLYING, DEAD}

var status = RUNNIG

func _ready():
	set_process_input(true)

func _physics_process(delta):

	if status == RUNNIG:
		running(delta)
	elif status == FLYING:
		flying(delta)
	elif status == DEAD:
		dead(delta)

	if status != DEAD:
		if position.y > ProjectSettings.get_setting("display/window/size/height"):
			killed()

	jump = false
	jump_release = false

func running(delta):
	velocity.y += grav * delta
	velocity.x = vel_x
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		if not was_on_floor:
			$anim_landed.play("boing")
			$dust/anim.play("dust")
		$sprite.play("walk")
		if jump:
			jump(1000, true)
			$jump.play()
	else:
		$sprite.play("jump")
		if jump_release and velocity.y < 0 and controled_jump:
			velocity.y *= .3
		
	was_on_floor = is_on_floor()

func flying(delta):
	velocity.y += grav * delta
	velocity.x = vel_x
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if jump:
		$flap.play()
		$wings/anim.play("flap")
		jump(500, false)

func dead(delta):
	$sprite.play("hurt")
	translate(velocity * delta)
	velocity.y += grav * delta

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			jump = true
		else:
			jump_release = true

func jump(force, controled):
	velocity.y = -force
	controled_jump = controled

func killed():
	if status != DEAD:
		status = DEAD
		collision_mask = 0
		collision_layer = 0
		velocity = Vector2(0, -1000)
		$dead.play()

func fly():
	$sprite.play("jump")
	status = FLYING
	jump(800, false)
	$wings.visible = true

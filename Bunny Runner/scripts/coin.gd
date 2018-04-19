extends Area2D

func _ready():
	pass


func _on_coin_body_entered( body ):
	$action.play()
	$sprite.visible = false
	collision_mask = 0
	$queue_timer.start()
	$particles.emitting = true


func _on_queue_timer_timeout():
	queue_free()

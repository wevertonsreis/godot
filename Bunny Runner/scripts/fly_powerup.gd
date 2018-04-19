extends Area2D

func _ready():
	pass

func _on_fly_powerup_body_entered( body ):
	body.fly()
	queue_free()

extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_method("instant_kill"):
		print("You died!")
		Engine.time_scale = 0.5
		body.instant_kill()
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0

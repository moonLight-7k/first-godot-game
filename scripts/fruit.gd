extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("[Fruit] body entered: ", body.name)
	if body.name == "Player":
		print("[Fruit] Player collected fruit! Fruits before: ", GameManager.fruits)
		GameManager.add_fruit("apple")
		print("[Fruit] Fruits after: ", GameManager.fruits)
		AudioManager.play_powerup()
		queue_free.call_deferred()

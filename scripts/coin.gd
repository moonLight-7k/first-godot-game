extends Area2D




func _on_body_entered(body: Node2D) -> void:
	print("[Coin] body entered: ", body.name)
	if body.name == "Player":
		print("[Coin] Player collected coin! Coins before: ", GameManager.coins)
		GameManager.add_coin()
		print("[Coin] Coins after: ", GameManager.coins)
		AudioManager.play_coin()
		queue_free.call_deferred()

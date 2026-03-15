extends Area2D




func _on_body_entered(body: Node2D) -> void:
	
	print("collison +1")
	queue_free()

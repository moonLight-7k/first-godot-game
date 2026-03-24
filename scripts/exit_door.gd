extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	pass

func _on_body_entered(body):
	if body.name == "Player":
		print("Level Complete!")

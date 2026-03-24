extends CanvasLayer

@onready var control: Control = $Control
@onready var lives_label: Label = $Control/VBoxContainer/LivesLabel

func _ready():
	visible = false

func show_death_screen():
	lives_label.text = "Lives Remaining: " + str(GameManager.lives - 1)
	visible = true
	print("[DeathScreen] Showing death screen, lives: ", GameManager.lives - 1)

func hide_death_screen():
	visible = false

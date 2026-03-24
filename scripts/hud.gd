extends CanvasLayer

@onready var lives_label: Label = $MarginContainer/VBoxContainer/LivesLabel
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var coins_label: Label = $MarginContainer/VBoxContainer/CoinsLabel
@onready var inventory_btn: Button = $MarginContainer/VBoxContainer/InventoryBtn

var inventory: Control = null

func _ready():
	print("[HUD] _ready called")
	inventory_btn.visible = false
	print("[HUD] inventory_btn hidden initially")

func _process(_delta):
	if lives_label:
		lives_label.text = "Lives: " + str(GameManager.lives)
	if health_label:
		health_label.text = "Health: " + str(GameManager.health)
	if coins_label:
		coins_label.text = "Coins: " + str(GameManager.coins)
	
	var has_items = GameManager.coins > 0 or GameManager.fruits.size() > 0
	if has_items != inventory_btn.visible:
		print("[HUD] inventory_btn visibility changed to: ", has_items, " (coins: ", GameManager.coins, ", fruits: ", GameManager.fruits.size(), ")")
	inventory_btn.visible = has_items

func _input(event):
	if event.is_action_pressed("inventory"):
		var has_items = GameManager.coins > 0 or GameManager.fruits.size() > 0
		if has_items:
			_toggle_inventory()
			get_viewport().set_input_as_handled()

func _toggle_inventory():
	if inventory == null:
		var parent = get_parent()
		if parent:
			inventory = parent.get_node_or_null("Inventory")
	
	if inventory:
		if inventory.visible:
			inventory.close_inventory()
		else:
			inventory.open_inventory()

func _on_inventory_btn_pressed():
	print("[HUD] _on_inventory_btn_pressed called")
	_toggle_inventory()

extends Control

@onready var panel: Control = $PanelContainer
@onready var grid_container: GridContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/GridContainer
@onready var close_btn: Button = $PanelContainer/MarginContainer/VBoxContainer/CloseBtn
@onready var coins_label: Label = $PanelContainer/MarginContainer/VBoxContainer/CoinsLabel

func _ready():
	print("[Inventory] _ready called")
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Ensure root fills screen
	set_anchors_preset(Control.PRESET_FULL_RECT)
	
	print("[Inventory] initialized")

func open_inventory():
	print("[Inventory] open_inventory called")
	visible = true
	
	# Pause game
	get_tree().paused = true
	
	# Wait one frame so UI gets correct size
	await get_tree().process_frame
	
	_center_panel()
	_update_display()

func close_inventory():
	print("[Inventory] close_inventory called")
	visible = false
	
	# Unpause game
	get_tree().paused = false

func _center_panel():
	if panel == null:
		return
	
	var viewport_size = get_viewport_rect().size
	
	# Center panel manually
	panel.position = (viewport_size - panel.size) / 2
	
	print("[Inventory] centered at: ", panel.position)

func _update_display():
	if grid_container == null:
		return
	
	# Clear old items
	for child in grid_container.get_children():
		child.queue_free()
	
	# Populate inventory
	if GameManager.fruits.size() == 0:
		var empty_label = Label.new()
		empty_label.text = "No items collected yet!"
		grid_container.add_child(empty_label)
	else:
		for fruit in GameManager.fruits:
			var label = Label.new()
			label.text = fruit
			grid_container.add_child(label)
	
	# Update coins
	if coins_label:
		coins_label.text = "Total Coins: " + str(GameManager.coins)

func _on_close_pressed():
	close_inventory()

func _input(event):
	if not visible:
		return
	
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("inventory"):
		close_inventory()
		get_viewport().set_input_as_handled()

func _unhandled_input(event):
	if not visible:
		return
	
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("inventory"):
		close_inventory()
		get_viewport().set_input_as_handled()

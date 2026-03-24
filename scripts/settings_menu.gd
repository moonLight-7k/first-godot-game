extends Control


@onready var music_slider: HSlider = $VBoxContainer/MusicVolumeSlider
@onready var sfx_slider: HSlider = $VBoxContainer/SFXVolumeSlider
@onready var fullscreen_checkbox: CheckBox = $VBoxContainer/FullscreenCheckBox


func _ready():
	music_slider.value = AudioManager.music_volume * 100
	sfx_slider.value = AudioManager.sfx_volume * 100
	fullscreen_checkbox.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN


func _on_music_volume_changed(value: float):
	AudioManager.set_music_volume(value / 100.0)


func _on_sfx_volume_changed(value: float):
	AudioManager.set_sfx_volume(value / 100.0)


func _on_fullscreen_toggled(button_pressed: bool):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if button_pressed else DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

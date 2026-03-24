extends Node

const JUMP_SOUND = preload("res://assets/sounds/jump.wav")
const COIN_SOUND = preload("res://assets/sounds/coin.wav")
const HURT_SOUND = preload("res://assets/sounds/hurt.wav")
const POWERUP_SOUND = preload("res://assets/sounds/power_up.wav")
const SWORD_SOUND = preload("res://assets/sounds/explosion.wav")
const TAP_SOUND = preload("res://assets/sounds/tap.wav")
const MUSIC = preload("res://assets/music/time_for_adventure.mp3")

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var music_volume: float = 1.0
var sfx_volume: float = 1.0


func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.stream = MUSIC
	music_player.volume_db = 0.0
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.volume_db = 0.0
	add_child(sfx_player)


func play_jump() -> void:
	_play_sfx(JUMP_SOUND)


func play_coin() -> void:
	_play_sfx(COIN_SOUND)


func play_hurt() -> void:
	_play_sfx(HURT_SOUND)


func play_sword() -> void:
	_play_sfx(SWORD_SOUND)


func play_powerup() -> void:
	_play_sfx(POWERUP_SOUND)


func play_tap() -> void:
	_play_sfx(TAP_SOUND)


func play_music() -> void:
	if not music_player.playing:
		music_player.play()


func stop_music() -> void:
	music_player.stop()


func set_music_volume(value: float) -> void:
	music_volume = value
	music_player.volume_db = _linear_to_db(value)


func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	sfx_player.volume_db = _linear_to_db(value)


func _play_sfx(stream: AudioStream) -> void:
	sfx_player.stream = stream
	sfx_player.play()


func _linear_to_db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return log(value) * 8.685889638065037

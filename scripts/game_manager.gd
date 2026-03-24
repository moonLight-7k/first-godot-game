extends Node


var health: int = 3
var lives: int = 3
var coins: int = 0
var fruits: Array = []


func _ready():
	print("[GameManager] Game Manager initialized")
	print("[GameManager] health: ", health, ", lives: ", lives, ", coins: ", coins, ", fruits: ", fruits)


func take_damage():
	health -= 1
	print("[GameManager] take_damage called - health: ", health)


func add_coin():
	coins += 1
	print("[GameManager] add_coin called - coins: ", coins)


func add_fruit(fruit_name):
	fruits.append(fruit_name)
	print("[GameManager] add_fruit called - fruits: ", fruits)


func reset_stats():
	health = 3
	print("[GameManager] reset_stats called - health: ", health)


func reset_game():
	health = 3
	lives = 3
	coins = 0
	fruits = []
	print("[GameManager] reset_game called - all stats reset")

extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const ROLL_SPEED = 180.0
const ROLL_DURATION = 0.5
const DOUBLE_TAP_TIME = 0.3

var is_attacking = false
const ATTACK_DURATION = 0.3
var attack_timer = 0.0

var is_hurt = false
var is_dying = false

var is_rolling = false
var roll_timer = 0.0
var roll_direction = 1

var last_move_time = 0.0
var last_move_direction = 0

var invincible = false
var invincibility_timer = 0.0
const INVINCIBILITY_DURATION = 1.5
const HIT_DURATION = 0.3
var hit_timer = 0.0

@onready var sword_hitbox: Area2D = $SwordHitbox
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if is_dying:
		return
	
	if is_hurt:
		hit_timer -= delta
		if hit_timer <= 0:
			is_hurt = false
		else:
			move_and_slide()
			return
	
	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0:
			is_rolling = false
			invincible = false
		else:
			velocity.x = roll_direction * ROLL_SPEED
			if not is_on_floor():
				velocity += get_gravity() * delta
			move_and_slide()
			return
	
	if invincible:
		invincibility_timer -= delta
		if invincibility_timer <= 0:
			invincible = false

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		AudioManager.play_jump()

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Running")
	else:
		animated_sprite.play("Jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_key_pressed(KEY_Z) and not is_attacking and is_on_floor() and not is_rolling:
		_attack()

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			if sword_hitbox:
				sword_hitbox.monitoring = false

	move_and_slide()

	_check_jump_kill()


func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_A or event.keycode == KEY_LEFT:
			_check_double_tap(-1)
		elif event.keycode == KEY_D or event.keycode == KEY_RIGHT:
			_check_double_tap(1)


func _check_double_tap(direction: int):
	if not is_on_floor() or is_rolling or is_hurt or is_dying:
		return
	
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if direction == last_move_direction and (current_time - last_move_time) < DOUBLE_TAP_TIME:
		_roll(direction)
		last_move_time = 0.0
		last_move_direction = 0
	else:
		last_move_time = current_time
		last_move_direction = direction


func _roll(direction: int):
	is_rolling = true
	roll_timer = ROLL_DURATION
	roll_direction = direction
	invincible = true
	animated_sprite.play("Roll")
	animated_sprite.flip_h = direction < 0
	print("[Player] Rolling ", "right" if direction > 0 else "left")


func _attack():
	is_attacking = true
	attack_timer = ATTACK_DURATION
	AudioManager.play_sword()
	if sword_hitbox:
		sword_hitbox.monitoring = true


func _check_jump_kill():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("enemy"):
			var collision_pos = collision.get_position()
			if collision_pos.y > position.y and velocity.y > 0:
				collider.die()
				velocity.y = JUMP_VELOCITY * 0.5
				return


func take_damage():
	if invincible or is_rolling or is_dying:
		return
	AudioManager.play_hurt()
	GameManager.take_damage()
	
	if GameManager.health <= 0:
		_die()
	else:
		animated_sprite.play("Hit")
		is_hurt = true
		hit_timer = HIT_DURATION
		invincible = true
		invincibility_timer = INVINCIBILITY_DURATION


func instant_kill():
	if is_dying:
		return
	GameManager.health = 0
	_die()


func _die():
	is_dying = true
	velocity = Vector2.ZERO
	animated_sprite.play("Dying")
	print("[Player] Playing death animation")
	
	var death_screen = get_tree().get_root().find_child("DeathScreen", true, false)
	if death_screen and death_screen.has_method("show_death_screen"):
		death_screen.show_death_screen()
	
	await get_tree().create_timer(0.8).timeout
	print("[Player] Death animation finished, restarting...")
	
	GameManager.lives -= 1
	if GameManager.lives > 0:
		GameManager.reset_stats()
		get_tree().reload_current_scene.call_deferred()
	else:
		GameManager.reset_game()
		get_tree().change_scene_to_file.call_deferred("res://scenes/main_menu.tscn")


func _on_sword_hitbox_body_entered(body):
	if is_attacking and body.is_in_group("enemy"):
		body.die()

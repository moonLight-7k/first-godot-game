extends CharacterBody2D

enum State { PATROL, CHASE, DEAD }

@export var speed: float = 50.0
@export var chase_speed: float = 70.0
@export var detection_radius: float = 150.0

var state = State.PATROL
var direction = 1
var player = null

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var detection_area = $DetectionArea
@onready var animated_sprite = $AnimatedSprite2D
@onready var hurt_box = $HurtBox

func _ready():
	add_to_group("enemy")

func _physics_process(_delta):
	if state == State.DEAD:
		return
	
	match state:
		State.PATROL:
			_patrol()
		State.CHASE:
			_chase()
	
	move_and_slide()

func _patrol():
	velocity.x = direction * speed
	
	if direction > 0:
		if ray_cast_right.is_colliding() or not ray_cast_down_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
	else:
		if ray_cast_left.is_colliding() or not ray_cast_down_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false
	
	if not is_on_floor():
		velocity += get_gravity()

func _chase():
	if player == null:
		state = State.PATROL
		return
	
	var to_player = player.global_position - global_position
	direction = sign(to_player.x)
	velocity.x = direction * chase_speed
	animated_sprite.flip_h = direction < 0
	
	if not is_on_floor():
		velocity += get_gravity()

func _on_player_detected(body):
	if body.name == "Player":
		player = body
		state = State.CHASE

func _on_player_lost(body):
	if body.name == "Player":
		player = null
		state = State.PATROL

func die():
	state = State.DEAD
	AudioManager.play_sword()
	queue_free.call_deferred()

func _on_hurt_box_body_entered(body):
	if body.name == "Player" and state != State.DEAD:
		body.take_damage()

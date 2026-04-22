extends CharacterBody2D

var speed = 200
var jump_force = -400
var gravity = 900
var jump_interval = 2.0
var jump_timer = 0.0

func _physics_process(delta):
	velocity.x = speed  # always move right

	if not is_on_floor():
		velocity.y += gravity * delta

	jump_timer -= delta
	if jump_timer <= 0 and is_on_floor():
		velocity.y = jump_force
		jump_timer = jump_interval

	move_and_slide()

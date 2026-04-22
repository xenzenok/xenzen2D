extends CharacterBody2D

var speed = 200
var jump_force = -400
var gravity = 900

func _physics_process(delta):
	var input_dir = 0
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir += 1

	velocity.x = input_dir * speed

	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

extends CharacterBody2D

var speed = 200
var jump_force = -400
var gravity = 900

func _physics_process(delta):
	# Horizontal movement
	var input_dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed

	# Vertical movement
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = jump_force
	else:
		velocity.y += gravity * delta

	move_and_slide()

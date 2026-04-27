extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var speed = 300
var last_direction = "down"  # default facing direction

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed

		# Handle diagonal priority (up/down wins over left/right)
		if input_vector.y < 0:
			anim.play("walkup")
			last_direction = "up"
		elif input_vector.y > 0:
			anim.play("walkdown")
			last_direction = "down"
		elif input_vector.x < 0:
			anim.play("walkleft")
			last_direction = "left"
		elif input_vector.x > 0:
			anim.play("walkright")
			last_direction = "right"
	else:
		velocity = Vector2.ZERO
		match last_direction:
			"up":
				anim.play("standstillup")
			"down":
				anim.play("standstilldown")
			"left":
				anim.play("standstilleft")
			"right":
				anim.play("standstillright")

	move_and_slide()

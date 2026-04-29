extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var speed = 250
var jump_force = -300
var gravity = 1200
var falling = false
var fall_timer = 0.0

func _ready():
	# Step right for 2 seconds
	anim.play("walkright")
	velocity.x = speed
	await get_tree().create_timer(2.0).timeout
	velocity.x = 0

	# Jump to the right
	anim.play("walkright")  # or use a "jump" animation if you have one
	velocity.x = speed
	velocity.y = jump_force
	falling = true

func _physics_process(delta):
	if falling:
		# Apply gravity
		velocity.y += gravity * delta
		move_and_slide()

		# Play falling animation (replace with "fall" if you have one)
		anim.play("falling")

		# Track fall duration
		fall_timer += delta
		if fall_timer >= 2.2:
			get_tree().change_scene_to_file("res://scenes/hub/Hub.tscn")

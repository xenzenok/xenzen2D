extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@export var speed: float = 10.0

var player: Node2D

func _ready():
	# Find the first node in the "Player" group
	player = get_tree().get_first_node_in_group("player")
	anim_sprite.play("default")

func _physics_process(delta):
	if player == null:
		return

	# Direction vector toward the player
	var direction = (player.global_position - global_position).normalized()

	# Move toward the player
	velocity = direction * speed
	move_and_slide()

	# Flip sprite depending on direction (optional)
	if direction.x != 0:
		anim_sprite.flip_h = direction.x < 0

extends CharacterBody2D

var speed = 600
var direction = Vector2.ZERO
var change_interval = 0.5
var timer = 0.0

func _ready():
	randomize()
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	timer -= delta
	if timer <= 0:
		timer = change_interval
		direction = pick_random_direction()
	velocity = direction * speed
	move_and_slide()

func pick_random_direction() -> Vector2:
	var dirs = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN, Vector2.ZERO]
	return dirs[randi() % dirs.size()]

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player touched NPC!")
		get_tree().change_scene_to_file("res://scenes/Battle.tscn")

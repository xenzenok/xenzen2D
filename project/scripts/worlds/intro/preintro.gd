extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var cam = $Camera2D   # Camera2D as child of player

var speed = 200
var cutscene_started = false
var stage = 0
var timer = 0.0

var walk_right_time = 3.5
var walk_up_time = 4.0

# Camera settings
var zoom_out = Vector2(2, 2)   # Wide establishing shot
var zoom_in = Vector2(1, 1)    # Normal zoom
var zoom_speed = 1.0
var pan_target = Vector2.ZERO  # Where to pan (player position)
var camera_ready = false

func _ready():
	# Start zoomed out and offset to show the whole shot
	cam.zoom = zoom_in
	cam.offset = Vector2(-150, -100)   # adjust to frame the scene
	# Begin cinematic zoom/pan
	_start_camera_trick()

func _start_camera_trick():
	# Smoothly animate zoom and pan using Tween
	var tween = create_tween()
	tween.tween_property(cam, "zoom", zoom_out, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(cam, "offset", pan_target, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.connect("finished", Callable(self, "_on_camera_ready"))

func _on_camera_ready():
	camera_ready = true

func _process(delta):
	# Only allow Enter once camera trick is done
	if camera_ready and Input.is_action_just_pressed("ui_accept") and not cutscene_started:
		cutscene_started = true
		stage = 1
		timer = 0.0
		anim.play("walkright")
		velocity.x = speed
		velocity.y = 0

func _physics_process(delta):
	if cutscene_started:
		move_and_slide()
		timer += delta

		if stage == 1 and timer >= walk_right_time:
			stage = 2
			timer = 0.0
			anim.play("walkup")
			velocity.x = 0
			velocity.y = -speed

		elif stage == 2 and timer >= walk_up_time:
			get_tree().change_scene_to_file("res://scenes/intro/PostIntro.tscn")

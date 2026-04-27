extends Node2D

@onready var interact_label = $InteractLabel
@onready var computer_ui = $ComputerUI
@onready var screen = $Screen

var player_near_screen = false

func _ready():
	interact_label.visible = false
	computer_ui.visible = false
	screen.connect("player_near", Callable(self, "_on_player_near"))

func _on_player_near(state: bool):
	player_near_screen = state
	interact_label.visible = state

func _process(_delta):
	if player_near_screen and Input.is_action_just_pressed("ui_accept"):
		computer_ui.visible = true
		interact_label.visible = false

	if computer_ui.visible and Input.is_action_just_pressed("ui_cancel"):
		computer_ui.visible = false


func _on_option_button_pressed() -> void:
	pass # Replace with function body.

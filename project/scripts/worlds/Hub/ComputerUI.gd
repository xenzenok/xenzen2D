extends CanvasLayer

@onready var world_selector = $PanelContainer/VBoxContainer/OptionButton
@onready var token_label = $PanelContainer/VBoxContainer/TokenLabel
@onready var confirm_button = $PanelContainer/VBoxContainer/Button
@onready var backdrop = $Backdrop   # A ColorRect covering the screen behind the panel

var tokens = 6

func _ready():
	# Initialize token display
	token_label.text = "Resubscribe Tokens Remaining: %d" % tokens

	# Populate world options
	world_selector.add_item("Fantasy")
	world_selector.add_item("Heaven")
	world_selector.add_item("Test")

	# Connect confirm button
	confirm_button.connect("pressed", Callable(self, "_on_Button_pressed"))

func _on_Button_pressed():
	var selected_world = world_selector.get_item_text(world_selector.selected)
	print("Going to: ", selected_world, " with ", tokens, " tokens")

	if tokens > 0:
		tokens -= 1
		token_label.text = "Resubscribe Tokens Remaining: %d" % tokens

		match selected_world:
			"Fantasy":
				get_tree().change_scene_to_file("res://scenes/fantasy/Fanatasy.tscn")
			"Heaven":
				get_tree().change_scene_to_file("res://scenes/heaven/HeavenWorld.tscn")
			"Test":
				get_tree().change_scene_to_file("res://scenes/test/Main.tscn")
			_:
				print("No scene mapped for: ", selected_world)
	else:
		print("No tokens left!")

func _on_Backdrop_input(event):
	if event is InputEventMouseButton and event.pressed:
		# Close the UI when clicking outside the panel
		visible = false

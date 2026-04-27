extends Area2D
signal player_near

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered screen area")
		emit_signal("player_near", true)

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited screen area")
		emit_signal("player_near", false)

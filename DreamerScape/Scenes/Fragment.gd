extends Area2D

signal collected

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("collected")
		$AudioStreamPlayer.play()
		queue_free()  # Remove the fragment from the scene

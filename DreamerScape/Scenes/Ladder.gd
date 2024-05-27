extends Area2D

signal player_entered_ladder
signal player_exited_ladder

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("player_entered_ladder", self)

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		emit_signal("player_exited_ladder", self)

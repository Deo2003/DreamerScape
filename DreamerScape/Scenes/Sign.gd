extends Area2D

@export var message: String

func _ready() -> void:
	$Label.visible = false
	$Label.text = message
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		$Label.visible = true

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		$Label.visible = false

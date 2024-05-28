extends Area2D

@export var next_scene: String

var is_open: bool = false

func _ready() -> void:
	$Padlock.play("locked")  # Play padlock locked animation
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func unlock() -> void:
	$Padlock.play("unlock")  # Play padlock unlock animation
	is_open = true
	$AnimatedSprite2D.play("openning")  # Play door opening animation

func _on_body_entered(body: Node) -> void:
	if body.name == "Player" and is_open:
		get_tree().change_scene_to_file(next_scene)

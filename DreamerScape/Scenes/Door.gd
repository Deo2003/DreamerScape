extends Area2D

@export var next_scene: String

var is_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))


func unlock() -> void:
	$Padlock.play("unlock")
	is_open = true
	$AnimatedSprite2D.play("openning")


func _on_body_entered(body: Node) -> void:
	if body.name == "Player" and is_open:
		get_tree().change_scene_to_file(next_scene)

# NPC1.gd
extends Area2D

@export var dialogue_scene: PackedScene

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		var dialogue_instance = dialogue_scene.instantiate()
		get_tree().root.add_child(dialogue_instance)

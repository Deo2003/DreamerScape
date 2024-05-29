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
		change_scene_with_loading("res://Scenes/LoadingScreen.tscn", next_scene)

func change_scene_with_loading(screen_path: String, next_scene_path: String):
	var loading_scene = ResourceLoader.load(screen_path)
	if loading_scene:
		var loading_instance = loading_scene.instantiate()
		get_tree().root.add_child(loading_instance)
		loading_instance.next_scene = next_scene_path
	else:
		print("Error loading scene: ", screen_path)

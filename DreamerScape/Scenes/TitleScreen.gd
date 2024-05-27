extends Node2D

@export var fade_duration: float = 1.0

func _ready() -> void:
	# Initially hide title and buttons
	$PlayButton.visible = false
	$Theme.play()

	# Connect the fade-in animation's finished signal to a function
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	
	# Connect the play button's pressed signal only if not connected already
	if not $PlayButton.is_connected("pressed", Callable(self, "_on_play_button_pressed")):
		$PlayButton.connect("pressed", Callable(self, "_on_play_button_pressed"))

func _on_play_button_pressed():
	change_scene_with_loading("res://Scenes/LoadingScreen.tscn", "res://Scenes/SlideshowScene.tscn")
	#get_tree().change_scene_to_file("res://Scenes/SlideshowScene.tscn")

func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "FadeIn":
		# Start the bounce animation
		$AnimationPlayer.play("Bounce")
		# Show title and buttons after fade-in animation
		$FadeRect.visible = false
		$PlayButton.visible = true

func change_scene_with_loading(screen_path: String, next_scene_path: String):
	var loading_scene = ResourceLoader.load(screen_path)
	if loading_scene:
		var loading_instance = loading_scene.instantiate()
		get_tree().root.add_child(loading_instance)
		loading_instance.next_scene = next_scene_path
	else:
		print("Error loading scene: ", screen_path)

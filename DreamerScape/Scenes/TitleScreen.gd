extends Node2D

@export var fade_duration: float = 1.0

func _ready() -> void:
	# Initially hide title and buttons
	$PlayButton.visible = false
	$ShopButton.visible = false
	$TutorialButton.visible = false

	# Connect the fade-in animation's finished signal to a function
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_FadeIn_finished"))
	$PlayButton.connect("pressed", Callable(self, "_on_play_button_pressed"))
	$ShopButton.connect("pressed", Callable(self, "_on_shop_button_pressed"))
	$TutorialButton.connect("pressed", Callable(self, "_on_tutorial_button_pressed"))


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/SlideshowScene.tscn")

func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ShopScene.tscn")


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TutorialScene.tscn")


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "FadeIn":
		# Start the bounce animation
		$AnimationPlayer.play("Bounce")
		# Show title and buttons after fade-in animation
		$FadeRect.visible = false
		$PlayButton.visible = true
		$ShopButton.visible = true
		$TutorialButton.visible = true
		

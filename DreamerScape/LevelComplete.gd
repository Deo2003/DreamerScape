# LevelComplete.gd
extends Control

@export var time_taken: float
@export var max_time_for_3_stars: float = 120.0  # Example threshold
@export var max_time_for_2_stars: float = 180.0  # Example threshold
@export var next_scene: String = "res://Scenes/NextLevel.tscn"  # Path to the next scene

func _ready() -> void:
	var stars = calculate_stars(time_taken)
	update_stars(stars)
	$TimeLabel.text = "Time: " + str(time_taken) + " seconds"
	$NextButton.connect("pressed", Callable(self, "_on_NextButton_pressed"))

func calculate_stars(time: float) -> int:
	if time <= max_time_for_3_stars:
		return 3
	elif time <= max_time_for_2_stars:
		return 2
	else:
		return 1

func update_stars(stars: int) -> void:
	$Star1.visible = stars >= 1
	$Star2.visible = stars >= 2
	$Star3.visible = stars >= 3

func _on_next_button_pressed() -> void:
	get_tree().change_scene(next_scene)


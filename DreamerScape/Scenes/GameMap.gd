extends Node2D

@export var required_stars: Array = [0, 5, 10, 15, 20, 25, 30]  # Example star requirements for each location
@export var star_count: int = 0  # This should be loaded from the player's save data

var location_buttons: Array = []
var hover_labels: Array = ["The Outskirts", "Gray Mountains", "The Woods", "Townsquare", "The Docks", "Castle District", "The Island"]  # Location names

func _ready() -> void:
	# Reference buttons for each location
	location_buttons.append($Location1Button)
	location_buttons.append($Location2Button)
	location_buttons.append($Location3Button)
	location_buttons.append($Location4Button)
	location_buttons.append($Location5Button)
	location_buttons.append($Location6Button)
	location_buttons.append($Location7Button)
	
	$HoverLabel.visible = false  # Hide the hover label initially
	
	# Initialize buttons based on star count
	for i in range(location_buttons.size()):
		var button = location_buttons[i]
		var locked_icon = button.get_node("LockedIcon")
		if star_count >= required_stars[i]:
			button.disabled = false
			locked_icon.visible = false
		else:
			button.disabled = true
			locked_icon.visible = true
		
		# Connect the button press signal to load the corresponding scene
		button.connect("pressed", Callable(self, "_on_location_button_pressed").bind(i))
		button.connect("mouse_entered", Callable(self, "_on_location_button_mouse_entered").bind(i))
		button.connect("mouse_exited", Callable(self, "_on_location_button_mouse_exited"))

func _on_location_button_pressed(index: int) -> void:
	$click.play()
	var scene_paths = [
		"res://Scenes/TheOutskirts.tscn",
		"res://Scenes/GrayMountains.tscn",
		"res://Scenes/TheWoods.tscn",
		"res://Scenes/Townsquare.tscn",
		"res://Scenes/TheDocks.tscn",
		"res://Scenes/CastleDistrict.tscn",
		"res://Scenes/TheIsland.tscn"
	]
	get_tree().change_scene_to_file(scene_paths[index])

func _on_location_button_mouse_entered(index: int) -> void:
	$hover.play()
	$HoverLabel.text = hover_labels[index]
	$HoverLabel.visible = true
	# Adjust the label position to be near the cursor or button
	$HoverLabel.global_position = get_viewport().get_mouse_position() + Vector2(20, -20)

func _on_location_button_mouse_exited() -> void:
	$HoverLabel.visible = false

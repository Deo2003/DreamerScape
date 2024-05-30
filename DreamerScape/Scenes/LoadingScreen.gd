extends Control

var next_scene = ""

func _ready():
	$Camera2D.make_current()
	# Connect the frame_changed signal to a function
	$AnimatedSprite2D.connect("frame_changed", Callable(self, "_on_animated_sprite_2d_frame_changed"))
	# Start playing the loading animation
	$AnimatedSprite2D.play("loading_animation")

	

func load_next_scene():
	var resource = ResourceLoader.load(next_scene)
	if resource:
		get_tree().change_scene_to_file(next_scene)
	else:
		print("Error loading scene: ", next_scene)

func _on_animated_sprite_2d_frame_changed():
	# Check if the animation has reached its last frame
	if $AnimatedSprite2D.frame == $AnimatedSprite2D.sprite_frames.get_frame_count("loading_animation") - 1:
		load_next_scene()
		queue_free()

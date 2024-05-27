extends CanvasLayer

@export var slides: Array = [
	{"image": "res://Assets/Slideshow/slide1.jpg", "text": "In the tranquil Kingdom of Prairie, life thrived amidst rolling hills, serene rivers, and bustling marketplaces. 
															The townsfolk went about their daily lives with joy, under the watchful protection of the castle. Peace and harmony
															reigned, with dreams as sweet as the gentle breeze that caressed the land."},
	{"image": "res://Assets/Slideshow/slide2.jpg", "text": "But peace was fleeting. Dark clouds gathered over the kingdom, bringing with them a torrential storm that mirrored
															the fear spreading among the people. As the rain poured down, an unsettling presence began to haunt the dreams of 
															the citizens."},
	{"image": "res://Assets/Slideshow/slide3.jpg", "text": "Monsters of darkness and dread crept into the dreams of Prairie’s citizens, turning serene nights into terrifying
															ordeals. These nightmarish creatures, born of fear and despair, roamed freely, causing havoc and distress. The 
															kingdom's once-peaceful nights were now plagued with shadows and fear, leaving the people yearning for solace."},
	{"image": "res://Assets/Slideshow/slide4.jpg", "text": "Yet, hope remained. Brave individuals known as Dreamers rose to the challenge, venturing into the very heart of 
															these nightmares. With courage and skill, they battled the monstrous invaders, restoring peace to the dreams of 
															Prairie’s people. In both the waking world and the realm of dreams, the Dreamers stand as steadfast guardians, 
															ensuring the safety and tranquility of their beloved kingdom."}
]

@export var slide_duration: float = 10.0

var current_slide: int = 0
var timer: Timer

func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_FadeIn_finished"))
	$AudioStreamPlayer.play()
	$SkipButton.connect("pressed", Callable(self, "_on_skip_button_pressed"))
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start(slide_duration)
	show_slide(current_slide)

func show_slide(index: int) -> void:
	if index >= slides.size():
		start_tutorial()
		return

	var slide = slides[index]
	$ImageSprite.texture = load(slide["image"])
	$TextLabel.text = slide["text"]
	$AnimatedSprite2D.play_backwards()
	$AnimatedSprite2D.play()

func start_tutorial() -> void:
	get_tree().change_scene_to_file("res://Scenes/TutorialScene.tscn")

func _on_skip_button_pressed() -> void:
	start_tutorial()

func _on_timer_timeout() -> void:
	current_slide += 1
	show_slide(current_slide)
	timer.start(slide_duration)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeIn":
		# Start the bounce animation
		$AnimationPlayer.play("Bounce")
		# Show title and buttons after fade-in animation
		$ColorRect.visible = false

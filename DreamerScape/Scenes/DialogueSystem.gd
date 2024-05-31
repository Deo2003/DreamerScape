# DialogueSystem.gd
extends CanvasLayer

@export var npc_image: Texture
@export var dialogue: Array[String] = []
@export var next_scene: String

var current_index: int = 0


func _ready() -> void:
	$Panel/TextureRect.texture = npc_image
	$Panel/Label.text = dialogue[current_index]
	$Panel/AcceptButton.disabled = true

	$Panel/NextButton.connect("pressed", Callable(self, "_on_NextButton_pressed"))
	$Panel/AcceptButton.connect("pressed", Callable(self, "_on_AcceptButton_pressed"))


func _on_accept_button_pressed():
	self.visible = false
	#get_tree().change_scene_to_file(next_scene)
	change_scene_with_loading("res://Scenes/LoadingScreen.tscn", "res://Scenes/Level1.tscn")


func _on_next_button_pressed():
	current_index += 1
	if current_index < dialogue.size():
		$Panel/Label.text = dialogue[current_index]
	else:
		$Panel/NextButton.disabled = true
		$Panel/AcceptButton.disabled = false

func change_scene_with_loading(screen_path: String, next_scene_path: String):
	var loading_scene = ResourceLoader.load(screen_path)
	if loading_scene:
		var loading_instance = loading_scene.instantiate()
		loading_instance.next_scene = next_scene_path
		get_tree().root.add_child(loading_instance)
	else:
		print("Error loading scene: ", screen_path)

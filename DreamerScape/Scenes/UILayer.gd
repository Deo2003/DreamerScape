# UILayer.gd
extends CanvasLayer

@export var total_fragments: int = 24
var collected_fragments: int = 0
var lives: int = 3

func _ready() -> void:
	update_lives()
	update_fragment_counter()

func update_lives() -> void:
	for i in range(3):
		var heart = $LivesContainer.get_child(i)
		heart.visible = i < lives

func update_fragment_counter() -> void:
	$FragmentCounter.text = str(collected_fragments) + "/" + str(total_fragments)

func add_fragment() -> void:
	collected_fragments += 1
	update_fragment_counter()
	if collected_fragments == total_fragments:
		open_door()

func lose_life() -> void:
	lives -= 1
	update_lives()
	if lives <= 0:
		game_over()

func open_door() -> void:
	var door = get_parent().get_node("Door")
	door.unlock()

func game_over() -> void:
	get_tree().reload_current_scene()

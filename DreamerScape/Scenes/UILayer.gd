# UILayer.gd
extends CanvasLayer

@export var total_fragments: int = 24
var collected_fragments: int = 0
var lives: int = 3
var start_time: float = 0.0

func _ready() -> void:
	update_lives()
	update_fragment_counter()
	start_time = Time.get_ticks_msec() / 1000.0
	set_process(true)

	call_deferred("_connect_to_game_manager")

func _connect_to_game_manager() -> void:
	var game_manager = get_parent().get_node("GameManager")
	if game_manager:
		game_manager.connect("fragment_collected", Callable(self, "_on_fragment_collected"))
	else:
		print("GameManager node not found")

func _process(delta: float) -> void:
	update_timer()

func update_lives() -> void:
	for i in range(3):
		var heart = $LivesContainer.get_child(i)
		heart.visible = i < lives

func update_fragment_counter() -> void:
	$FragmentCounter.text = str(collected_fragments) + "/" + str(total_fragments)

func update_timer() -> void:
	var elapsed_time = Time.get_ticks_msec() / 1000.0 - start_time
	$Timer.text = "Time: " + str(elapsed_time) + "s"

func add_fragment() -> void:
	collected_fragments += 1
	print("Fragments count: %d" % collected_fragments)
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

func _on_fragment_collected() -> void:
	add_fragment()

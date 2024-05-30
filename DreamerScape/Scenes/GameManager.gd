extends Node

var fragment_count: int = 0
var door: Area2D
var chime_player: AudioStreamPlayer

func _ready() -> void:
	var pause_menu = preload("res://Scenes/PauseMenu.tscn").instantiate()
	get_tree().root.add_child(pause_menu)
	door = get_node_or_null("Door")
	if not door:
		print("Error: Door node not found!")
	else:
		door.connect("body_entered", Callable(self, "_on_body_entered"))

	var player = get_node_or_null("Player")
	if player:
		player.connect("player_entered_hiding", Callable(self, "_on_Player_player_entered_hiding"))
		player.connect("player_exited_hiding", Callable(self, "_on_Player_player_exited_hiding"))
	else:
		print("Player node not found")
	chime_player = get_node("FragmentChime")
	for fragment in get_tree().get_nodes_in_group("Fragments"):
		fragment.connect("collected", Callable(self, "_on_fragment_collected"))

func _on_fragment_collected() -> void:
	fragment_count += 1
	print("Fragments collected: %d" % fragment_count)
	chime_player.play()
	if fragment_count == 10:
		door.unlock()

func _on_Player_player_entered_hiding(hiding_spot: Area2D) -> void:
	print("Player entered hiding spot")

func _on_Player_player_exited_hiding(hiding_spot: Area2D) -> void:
	print("Player exited hiding spot")

extends Node

var fragment_count: int = 0
var door: Area2D
var chime_player: AudioStreamPlayer

func _ready() -> void:
	door = get_node("Door")
	var player = get_node("Player")
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

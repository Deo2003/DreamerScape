extends Node

var fragment_count: int = 0

func _ready() -> void:
	for fragment in get_tree().get_nodes_in_group("Fragments"):
		fragment.connect("collected", Callable(self, "_on_fragment_collected"))

func _on_fragment_collected() -> void:
	fragment_count += 1
	print("Fragments collected: %d" % fragment_count)

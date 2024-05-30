extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var pause_menu = preload("res://Scenes/PauseMenu.tscn").instantiate()
	get_tree().root.add_child(pause_menu)
	$AudioStreamPlayer.play()
	$Fragment/AnimationPlayer.play("bounce")
	var player = get_node("Player")
	if player:
		for ladder in get_tree().get_nodes_in_group("Ladders"):
			ladder.connect("player_entered_ladder", Callable(player, "_on_Ladder_player_entered_ladder"))
			ladder.connect("player_exited_ladder", Callable(player, "_on_Ladder_player_exited_ladder"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

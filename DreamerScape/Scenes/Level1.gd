# LevelOne.gd
extends Node2D

func _ready() -> void:
	var player = $Player
	var ui_layer = $UILayer
	player.connect("fragment_collected", Callable(ui_layer, "_on_Player_fragment_collected"))
	
	if player:
		for ladder in get_tree().get_nodes_in_group("Ladders"):
			ladder.connect("player_entered_ladder", Callable(player, "_on_Ladder_player_entered_ladder"))
			ladder.connect("player_exited_ladder", Callable(player, "_on_Ladder_player_exited_ladder"))

# Global.gd
extends Node

var pause_menu_scene: PackedScene
var pause_menu_instance: Control

func _ready():
	# Load the pause menu scene
	pause_menu_scene = load("res://PauseMenu.tscn")

func toggle_pause():
	if get_tree().paused:
		close_pause_menu()
	else:
		open_pause_menu()

func open_pause_menu():
	if not pause_menu_instance:
		pause_menu_instance = pause_menu_scene.instance()
		get_tree().root.add_child(pause_menu_instance)
	get_tree().paused = true
	pause_menu_instance.show()

func close_pause_menu():
	if pause_menu_instance:
		pause_menu_instance.hide()
	get_tree().paused = false

func on_mute_pressed():
	var master_bus = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus)
	AudioServer.set_bus_mute(master_bus, not is_muted)

func on_home_pressed():
	close_pause_menu()
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func on_quit_pressed():
	get_tree().quit()

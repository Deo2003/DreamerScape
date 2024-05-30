# PauseMenu.gd
extends Control

var is_paused: bool = false

func _ready() -> void:
	self.visible = false  # Initially hide the pause menu
	$Panel/VBoxContainer/Mute.connect("pressed", Callable(self, "_on_mute_pressed"))
	$Panel/VBoxContainer/Home.connect("pressed", Callable(self, "_on_home_pressed"))
	$Panel/VBoxContainer/Quit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _input(event):
	if event.is_action_pressed("pause"):
		_toggle_pause()

func _toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused
	self.visible = is_paused
	print("Paused:", is_paused)  # Debugging statement

func _on_quit_pressed():
	get_tree().quit()

func _on_home_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func _on_mute_pressed():
	var master_bus = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus)
	AudioServer.set_bus_mute(master_bus, not is_muted)

# PauseMenu.gd
extends Control

var is_paused: bool = false

func _ready() -> void:
	self.visible = false  # Initially hide the pause menu
	$VBoxContainer/HSlider.connect("value_changed", self, "_on_volume_changed")
	$VBoxContainer/MuteButton.connect("pressed", self, "_on_mute_button_pressed")
	$VBoxContainer/MainMenuButton.connect("pressed", self, "_on_main_menu_button_pressed")
	$VBoxContainer/QuitButton.connect("pressed", self, "_on_quit_button_pressed")

func _input(event):
	if event.is_action_pressed("ui_pause"):
		_toggle_pause()

func _toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused
	self.visible = is_paused

func _on_volume_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_mute_button_pressed():
	var is_muted = AudioServer.is_bus_muted(AudioServer.get_bus_index("Master"))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), not is_muted)
	$VBoxContainer/MuteButton.text = "Unmute" if is_muted else "Mute"

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://MainMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

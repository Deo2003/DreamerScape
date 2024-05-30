# PauseMenu.gd
extends Control

func _ready() -> void:
	self.visible = false  # Initially hide the pause menu
	$Panel/VBoxContainer/Mute.connect("pressed", Callable(self, "_on_mute_pressed"))
	$Panel/VBoxContainer/Home.connect("pressed", Callable(self, "_on_home_pressed"))
	$Panel/VBoxContainer/Quit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			_on_close_pressed()
		else:
			_on_pause_button_pressed()

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	show()

func _on_mute_pressed() -> void:
	var master_bus = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus)
	AudioServer.set_bus_mute(master_bus, not is_muted)

func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_close_pressed():
	hide()
	get_tree().paused = false

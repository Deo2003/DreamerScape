# NightmareRound.gd
extends Node2D

@export var correct_sequence: Array[String] = ["E", "G", "A", "B", "C", "B", "A", "G", "E"]  # Example correct sequence
var player_sequence: Array[String] = [] 
var note_sounds: Dictionary = {}

func _ready() -> void:
	# Load the sound files for each note and assign them to the buttons
	note_sounds["C"] = preload("res://Assets/Audio/Notes/C.ogg")
	note_sounds["D"] = preload("res://Assets/Audio/Notes/D.ogg")
	note_sounds["E"] = preload("res://Assets/Audio/Notes/E.ogg")
	note_sounds["F"] = preload("res://Assets/Audio/Notes/F.ogg")
	note_sounds["G"] = preload("res://Assets/Audio/Notes/G.ogg")
	note_sounds["A"] = preload("res://Assets/Audio/Notes/A.ogg")
	note_sounds["B"] = preload("res://Assets/Audio/Notes/B.ogg")
	
	# Connect the buttons to the signal
	$ButtonC.connect("pressed", Callable(self, "_on_button_pressed_C"))
	$ButtonD.connect("pressed", Callable(self, "_on_button_pressed_D"))
	$ButtonE.connect("pressed", Callable(self, "_on_button_pressed_E"))
	$ButtonF.connect("pressed", Callable(self, "_on_button_pressed_F"))
	$ButtonG.connect("pressed", Callable(self, "_on_button_pressed_G"))
	$ButtonA.connect("pressed", Callable(self, "_on_button_pressed_A"))
	$ButtonB.connect("pressed", Callable(self, "_on_button_pressed_B"))

func _on_button_c_pressed() -> void:
	_on_note_pressed("C")

func _on_button_d_pressed() -> void:
	_on_note_pressed("D")

func _on_button_e_pressed() -> void:
	_on_note_pressed("E")

func _on_button_f_pressed() -> void:
	_on_note_pressed("F")

func _on_button_g_pressed() -> void:
	_on_note_pressed("G")

func _on_button_a_pressed() -> void:
	_on_note_pressed("A")

func _on_button_b_pressed() -> void:
	_on_note_pressed("B")

func _on_note_pressed(note: String) -> void:
	player_sequence.append(note)
	play_note_sound(note)
	
	# Check if the player sequence matches the correct sequence
	if player_sequence.size() == correct_sequence.size():
		if player_sequence == correct_sequence:
			win_level()
		else:
			lose_level()

func play_note_sound(note: String) -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = note_sounds[note]
	add_child(sound)
	sound.play()
	sound.connect("finished", sound.queue_free)  # Remove the sound player after playing

func win_level() -> void:
	print("You have vanquished the nightmare!")
	get_tree().change_scene_to_file("res://Scenes/LevelComplete.tscn")

func lose_level() -> void:
	print("Incorrect sequence. Try again.")
	player_sequence.clear()


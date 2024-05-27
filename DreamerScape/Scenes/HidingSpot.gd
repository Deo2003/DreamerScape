extends Area2D

signal player_entered_hiding
signal player_exited_hiding

func _ready() -> void:
	$HidingZone.connect("body_entered", Callable(self, "_on_HidingZone_body_entered"))
	$HidingZone.connect("body_exited", Callable(self, "_on_HidingZone_body_exited"))

func _on_hiding_zone_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered_hiding", self)
 

func _on_hiding_zone_body_exited(body):
	if body.name == "Player":
		emit_signal("player_exited_hiding", self)

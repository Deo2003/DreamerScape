extends CharacterBody2D

@export var speed: float = 50.0
@export var damage: int = 1
@export var pace_distance: float = 100.0

var direction: Vector2 = Vector2.LEFT
var initial_position: Vector2

func _ready() -> void:
	initial_position = global_position

func _physics_process(delta: float) -> void:
	move_and_slide(direction * speed)
	if abs(global_position.x - initial_position.x) > pace_distance:
		direction *= -1

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.take_damage(damage)
		if body.is_bouncing_on_head(self):
			queue_free()

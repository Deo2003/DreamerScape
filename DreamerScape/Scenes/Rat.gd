extends CharacterBody2D

@export var speed: float = 50.0
@export var pace_distance: float = 100.0
@export var damage: int = 1

var direction: Vector2 = Vector2.LEFT
var initial_position: Vector2

func _ready() -> void:
	initial_position = global_position
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$AnimatedSprite2D.play("walk")  # Ensure you have a walk animation

func _physics_process(delta: float) -> void:
	velocity.x = direction.x * speed
	move_and_slide()
	if abs( initial_position.x - global_position.x) > pace_distance:
		direction *= -1
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		if body.is_bouncing_on_head(self):
			$AnimationPlayer.play("die")
			$AnimatedSprite2D.visible = false
			queue_free()

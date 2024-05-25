extends CharacterBody2D

@export var speed: float = 100.0
@export var move_range: float = 200.0

var direction: int = 1
var start_position: Vector2
var is_dead: bool = false

func _ready() -> void:
	$EnemySprite.play("roam")
	start_position = global_position
	$HeadArea2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))

func _process(delta: float) -> void:
	if is_dead:
		return

	# Move back and forth
	global_position.x += speed * delta * direction
	if abs(global_position.x - start_position.x) > move_range:
		direction *= -1

func _on_HeadBounced():
	if not is_dead:
		is_dead = true
		$EnemySprite.play("die")
		# Optionally, make the enemy fall off the screen
		$Tween.tween_property(self, "global_position:y", global_position.y + 200, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		_on_HeadBounced()
		body._on_EnemyBounced() # Notify Player script
	

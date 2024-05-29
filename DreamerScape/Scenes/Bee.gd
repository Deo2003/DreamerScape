extends CharacterBody2D

@export var speed: float = 100.0
@export var detection_range: float = 200.0
@export var damage: int = 1

var player: Node2D

func _ready() -> void:
	player = get_tree().root.get_node("TutorialScene/Player")
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	if player and not player.is_hiding:
		var distance = global_position.distance_to(player.global_position)
		if distance < detection_range:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
		else:
			velocity = Vector2.ZERO
	move_and_slide()

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.take_damage(damage)
		


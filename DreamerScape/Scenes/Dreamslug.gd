extends CharacterBody2D

@export var speed: float = 50.0
@export var detection_range: float = 200.0
@export var detection_color: Color = Color.RED
@export var move_range: float = 200.0

var original_color: Color
var player: Node2D
var direction: int = 1
var start_position: Vector2

func _ready() -> void:
	if $Sprite2D != null:
		original_color = $Sprite2D.modulate
		print("Sprite2D found and original color set.")
	else:
		print("Sprite2D not found.")

	player = get_tree().get_root().get_node("TutorialScene/Player")
	if player != null:
		print("Player found.")
	else:
		print("Player not found.")
	
	start_position = global_position

func _process(delta: float) -> void:
	if player != null and "is_hiding" in player:
		if not player.is_hiding:
			var distance = global_position.distance_to(player.global_position)
			if distance < detection_range:
				if $Sprite2D != null:
					$Sprite2D.modulate = original_color.lerp(detection_color, 1.0 - (distance / detection_range))
			else:
				if $Sprite2D != null:
					$Sprite2D.modulate = original_color

	# Move back and forth
	global_position.x += speed * delta * direction
	if abs(global_position.x - start_position.x) > move_range:
		direction *= -1

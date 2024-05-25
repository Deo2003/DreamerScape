extends CharacterBody2D

@export var walk_speed: float = 150.0
@export var run_speed: float = 250.0
@export var jump_force: float = 575.0
@export var gravity: float = 900.0

var is_hiding: bool = false
var is_jumping: bool = false
var is_falling: bool = false

func _ready() -> void:
	$RayCast2D.enabled = true
	$PlayerSprite.play("idle")  # Start with the idle animation
	$Camera2D.make_current()  # Correct usage without assignment

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		return

	if get_tree().paused:
		return

	handle_movement()
	handle_jump()
	handle_hiding()
	velocity.y += gravity * delta
	move_and_slide()

func handle_movement() -> void:
	var speed = walk_speed
	if Input.is_action_pressed("ui_shift"):
		speed = run_speed

	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$PlayerSprite.flip_h = false  # Ensure the sprite is facing right
		if not is_jumping and not is_falling:
			if speed == walk_speed:
				$PlayerSprite.play("walk")  # Play walk animation
			elif speed == run_speed:
				$PlayerSprite.play("run")  # Play run animation
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		$PlayerSprite.flip_h = true  # Ensure the sprite is facing left
		if not is_jumping and not is_falling:
			if speed == walk_speed:
				$PlayerSprite.play("walk")  # Play walk animation
			elif speed == run_speed:
				$PlayerSprite.play("run")  # Play run animation
	else:
		if is_on_floor() and not is_jumping and not is_falling:
			$PlayerSprite.play("idle")  # Play idle animation

func handle_jump() -> void:
	if is_on_floor() and Input.is_action_just_pressed("ui_jump"):
		$PlayerSprite.play("jump")  # Play jump animation
		velocity.y = -jump_force
		is_jumping = true
		is_falling = false
	elif not is_on_floor():
		if velocity.y > 0 and not is_falling:
			$PlayerSprite.play("fall")  # Play fall animation
			is_falling = true
			is_jumping = false
	else:
		is_jumping = false
		is_falling = false

func handle_hiding() -> void:
	if Input.is_action_just_pressed("hide"):
		is_hiding = !is_hiding
		$PlayerSprite.visible = not is_hiding

func _on_EnemyBounced():
	velocity.y = -jump_force / 2 # Gives the player a bounce effect 

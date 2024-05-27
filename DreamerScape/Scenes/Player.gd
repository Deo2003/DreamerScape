extends CharacterBody2D

@export var walk_speed: float = 150.0
@export var run_speed: float = 250.0
@export var jump_force: float = 575.0
@export var gravity: float = 900.0
@export var ladder_speed: float = 100.0

var is_hiding: bool = false
var hiding_spot: Area2D = null
var is_jumping: bool = false
var is_falling: bool = false
var is_on_ladder: bool = false
var current_ladder: Area2D = null

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
	
	if is_on_ladder:
		handle_ladder_movement()

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
		$jump_sfx.play()
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
	if hiding_spot and Input.is_action_just_pressed("ui_accept"):
		is_hiding = !is_hiding
		$PlayerSprite.visible = not is_hiding
		if is_hiding:
			global_position = hiding_spot.global_position
			hiding_spot.get_node("Sprite2D").modulate.a = 0.5
		else:
			hiding_spot.get_node("Sprite2D").modulate.a = 1.0

func _on_HidingSpot_player_entered_hiding(hiding_spot: Area2D) -> void:
	self.hiding_spot = hiding_spot

func _on_HidingSpot_player_exited_hiding(hiding_spot: Area2D) -> void:
	if self.hiding_spot == hiding_spot:
		self.hiding_spot = null

func handle_ladder_movement() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= ladder_speed
		$PlayerSprite.play("climb")  # Play climb animation
	elif Input.is_action_pressed("ui_down"):
		velocity.y += ladder_speed
		$PlayerSprite.play("climb")  # Play climb animation
	else:
		$PlayerSprite.play("idle")  # Play idle animation

func _on_Ladder_player_entered_ladder(ladder: Area2D) -> void:
	is_on_ladder = true
	current_ladder = ladder
	gravity = 0  # Disable gravity while on the ladder

func _on_Ladder_player_exited_ladder(ladder: Area2D) -> void:
	if current_ladder == ladder:
		is_on_ladder = false
		current_ladder = null
		gravity = 900  # Re-enable gravity when off the ladder

func _on_EnemyBounced():
	velocity.y = -jump_force / 2 # Gives the player a bounce effect 

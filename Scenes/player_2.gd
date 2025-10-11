extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@export var spawnpoint: Node2D 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var health: int = 5
var max_health: int = 5

signal health_changed(current_health: int, max_health: int)
signal player_died

func _ready() -> void:
	emit_signal("health_changed", health, max_health)

func reset_health() -> void:
	health = max_health
	emit_signal("health_changed", health, max_health)

func take_damage(amount: int) -> void:
	health -= amount
	if health < 0:
		health = 0
	emit_signal("health_changed", health, max_health)

	if health <= 0:
		emit_signal("player_died")
		reset_health()

func respawn() -> void:
	global_position = spawnpoint.global_position


func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Handle left/right movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0

		if abs(velocity.x) > SPEED * 0.5:
			anim.play("run")
		else:
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("idle")

	# If in air falling
	if not is_on_floor() and velocity.y > 0:
		anim.play("jump")

	move_and_slide()

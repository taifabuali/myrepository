extends CharacterBody2D

@export var speed: float = 100.0
@export var patrol_distance: float = 200.0
@export var damage: int = 1
@export var damage_interval: float = 1.0 
@export var start_direction: int = 1 

var start_position: Vector2
var direction: int
var touching_player: Node = null
var damage_timer: Timer

func _ready() -> void:
	start_position = global_position
	direction = start_direction
	

	# Create a timer for damage cooldown
	damage_timer = Timer.new()
	damage_timer.wait_time = damage_interval
	damage_timer.one_shot = false
	damage_timer.autostart = false
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	add_child(damage_timer)

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	move_and_slide()

	if abs(global_position.x - start_position.x) >= patrol_distance:
		direction *= -1
		$AnimatedSprite2D.flip_h = direction < 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		touching_player = body
		damage_timer.start()  # start applying damage over time

func _on_body_exited(body: Node) -> void:
	if body == touching_player:
		touching_player = null
		damage_timer.stop()  # stop damage when player leaves

func _on_damage_timer_timeout() -> void:
	if touching_player:
		touching_player.take_damage(damage)

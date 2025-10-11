extends Node2D

@export var fall_delay: float = 0.5
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var area: Area2D = $Area2D

var is_triggered: bool = false

func _ready() -> void:
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and not is_triggered:
		is_triggered = true
		# wait before falling
		await get_tree().create_timer(fall_delay).timeout
		anim_player.play("fall")

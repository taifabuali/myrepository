extends Area2D

@export var collectible_type: String = "coin" 
@export var value: int = 1  

signal collected(collectible_type: String, value: int)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("collected", collectible_type, value)
		queue_free() 

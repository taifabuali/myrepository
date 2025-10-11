extends Area2D

@export var damage: int = 1

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") :
		body.take_damage(damage)
		body.respawn() 

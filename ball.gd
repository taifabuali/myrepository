extends RigidBody2D

#func _ready():
	#gravity_scale = 1 
	
func  _input(event):
	if event.is_action_pressed("ui_accept"):
		apply_impulse(Vector2(0, -500))

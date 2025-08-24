extends CharacterBody2D

const SPeed = 200
const  JUMP_FORCE = -400
@export var Velocity = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += 1000 * delta;
	
	velocity.x=0
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPeed
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -=SPeed
		
	if Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_FORCE
	
	Velocity = move_and_slide()
   

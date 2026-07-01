extends CharacterBody2D

var direction_x: float
var speed = 50
var jump_strength = 400
var gravity := 1000
signal shoot(pos:Vector2,dir:Vector2)

func get_input():
	direction_x = Input.get_axis("left","right")
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_strength
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left ==0:
		shoot.emit(position, get_local_mouse_position().normalized())
		$ReloadTimer.start()
		pass 
	pass

func apply_gravity(delta):
	velocity.y += gravity * delta
	pass

func _physics_process( delta: float) -> void:
	get_input()
	velocity.x = direction_x *  speed
	apply_gravity(delta)
	move_and_slide()
	pass

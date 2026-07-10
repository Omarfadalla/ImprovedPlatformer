extends CharacterBody2D

var direction_x: float
var speed = 50
var jump_strength = 400
var gravity := 1000
signal shoot(pos:Vector2,dir:Vector2)


const gun_pointing_animations = {
	Vector2i(1,0):   0,
	Vector2i(1,1):   1,
	Vector2i(0,1):   2,
	Vector2i(-1,1):  3,
	Vector2i(-1,0):  4,
	Vector2i(-1,-1): 5,
	Vector2i(0,-1):  6,
	Vector2i(1,-1):  7,
	
}

func get_input():
	direction_x = Input.get_axis("left","right")
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_strength
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left ==0:
		shoot.emit(position, get_local_mouse_position().normalized())
		$AnimationPlayer2.play("shoot scaling")
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
	animation()
	update_crosshair()
	pass


func animation():
	$Legs.flip_h = direction_x < 0
	if is_on_floor():
		$AnimationPlayer.current_animation = "run" if direction_x else "idle"
	else:
		$AnimationPlayer.current_animation = "Jump"
	
	var pointer_dir = get_local_mouse_position().normalized()
	var adjusted_dir = Vector2i(round(pointer_dir.x),round(pointer_dir.y))
	$Torso.frame = gun_pointing_animations[adjusted_dir]
	pass
	
	
func update_crosshair():
	$Marker.position = get_local_mouse_position().normalized() * 50
	pass

extends CharacterBody2D
signal died
var direction: Vector2 
var speed: = 50
var player: CharacterBody2D
var health := 3
var is_exploding : bool = false
func _ready() -> void:
	add_to_group("Drones")
func _on_area_detection_body_entered(Player_body: CharacterBody2D) -> void:
	
	player = Player_body
	
	pass # Replace with function body.
 
func _physics_process(delta: float) -> void:
	
	if player:
		var dir  = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()
		
	
	pass
func _on_area_detection_body_exited(_player_body: CharacterBody2D) -> void:
	
	player = null
	
	
	pass # Replace with function body.
func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.has_method("hit") and body.is_in_group("Player"):
		body.hit()
	explode()
func hit():
	health -= 1
	if health <= 0 :
		is_exploding = true
		explode() 
	$AnimatedSprite2D.material.set_shader_parameter("Progress" , 0.0)
func explode():
	if is_exploding and speed == 0:
		return
	is_exploding = true
	speed = 0
	$AnimatedSprite2D.hide()
	$ExplosionSprite.show()
	$AnimationPlayer.play("explode")
	$AudioStreamPlayer2D.play()
	died.emit()
	await $AnimationPlayer.animation_finished
	queue_free() 
func chain_reaction():
		for drone in get_tree().get_nodes_in_group('Drones'):
			if position.distance_to(drone.position) < 20 :
				if not is_exploding:
					drone.explode()

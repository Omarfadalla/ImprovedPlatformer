extends CharacterBody2D

var direction: Vector2 
var speed: = 50
var player: CharacterBody2D
var health := 4

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


func _on_collision_area_body_entered(_body: Node2D) -> void:
	explode()

func hit():
	health -= 1
	if health <= 0 :
		explode() 

func explode():
	speed = 0
	$AnimatedSprite2D.hide()
	$ExplosionSprite.show()
	$AnimationPlayer.play("explode")
	await $AnimationPlayer.animation_finished
	queue_free() 
func chain_reaction():
		for drone in get_tree().get_nodes_in_group('Drones'):
			if position.distance_to(drone.position) < 20 :
				drone.explode()
	

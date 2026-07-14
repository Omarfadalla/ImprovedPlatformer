extends CharacterBody2D

var direction: Vector2 
var speed: = 50
var player: CharacterBody2D


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

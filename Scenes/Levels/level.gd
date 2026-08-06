extends Node2D

var bullet_scene = preload("res://Scenes/bullets/bullet.tscn")


func _ready() -> void:
	var light_tween = create_tween()
	light_tween.set_loops()

	light_tween.tween_property($PointLight2D , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D , "energy",0.5 ,0.7)
	
	light_tween.tween_property($PointLight2D2 , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D2 , "energy",0.5 ,0.7)
	
	light_tween.tween_property($PointLight2D3 , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D3, "energy",0.5 ,0.7)
	
	light_tween.tween_property($PointLight2D4 , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D4 , "energy",0.5 ,0.7)
	
	light_tween.tween_property($PointLight2D5 , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D5, "energy",0.5 ,0.7)
	
	light_tween.tween_property($PointLight2D6 , "energy",1.5 ,0.7)
	light_tween.tween_property($PointLight2D6, "energy",0.5 ,0.7)


func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
	
	var bullet = bullet_scene.instantiate() as Area2D
	$Bullets.add_child(bullet)
	bullet.setup(pos , dir)
	pass # Replace with function body.
 

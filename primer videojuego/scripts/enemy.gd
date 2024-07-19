extends CharacterBody2D

class_name Enemy

@export_category("Config")
@export_group("Options")

@export var health : int = 1
@export var score : int = 100
 
@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

var direction : int = 1

func _proces(_delta):
	if health > 0:
		motion_ctrl()
		
func motion_ctrl() -> void:
	$SpriteEnemy.scale.x = direction
	
	if not $SpriteEnemy/RayCast2D.is_colliding() or is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()
	
func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$SpriteEnemy.set_animation("death")
		$CollisionEnemy.set_deferred("disabled", true)
		
		gravity = 0
		Global.score += score

func _on_sprite_enemy_animation_finished():
	if $SpriteEnemy.animation == "death":
		queue_free()
	
	
func _on_area_hit_body_entered(body):

	if body is Player and health > 0:
		body.damage_ctrl()

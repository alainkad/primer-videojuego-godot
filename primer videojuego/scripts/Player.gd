extends CharacterBody2D

class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false

@export_category("config")
@export_group("referencias requeridas")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 128
@export var gravity : int = 16
@export var jump : int = 368

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()
			
func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)

 
func get_axis() -> Vector2:
	axis.x = int (Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	if not get_axis().x == 0:
		$AnimatedSprite.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$AnimatedSprite.play("run")
			else:
				$AnimatedSprite.play("idle")
		false:
			if velocity.y < 0:
				$AnimatedSprite.play("jump")
			else: 
				$AnimatedSprite.play("fall")

func death_ctrl() -> void: 
	velocity.x = 0
	velocity.y = gravity 
	move_and_slide()
	
func jump_ctrl(power : float) -> void:
	velocity.y = -jump * power
	
func damage_ctrl() -> void:
	death = true
	$AnimatedSprite.set_animation("death")
	
	
func _on_area_2d_body_entered(body):
	if body is Enemy and velocity.y >= 0:
		body.damage_ctrl()
		jump_ctrl(0.75) 




func _on_animated_sprite_animation_finished():
	if $AnimatedSprite.play == "death":
		gui.game_over()
	

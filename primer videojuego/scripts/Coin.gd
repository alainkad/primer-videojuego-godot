extends Area2D



func _on_body_entered(body):
	if body is Player:
		$SpriteCoin.set_animation("off")
		Global.score += 100
		

extends CanvasLayer

func _process(delta):
	$MarginContainer/Label.text = "SCORE: " + str(Global.score)
	
func game_over() -> void:
	get_tree().paused = true
	$ColorRect/VBoxContainer/HBoxContainer/Reiniciar.grab_focus()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0.8), 1.0)
	
	
	

func _on_reiniciar_pressed():
	get_tree().reload_current_scene()


func _on_salir_pressed():
	get_tree().quit()

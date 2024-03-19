extends Panel

func _process(_delta):
	rect_position = Vector2(get_global_mouse_position().x + 10, get_global_mouse_position().y + 10)

func _on_Timer_timeout():
	$AnimationPlayer.play("Fadeout")
	yield ($AnimationPlayer, "animation_finished")

func text(text):
	$Label.text = text
	if text == "Already Searched":
		modulate = Color("968989")

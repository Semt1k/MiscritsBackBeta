extends Control
var dat = []
var crateid
var opened = false



var colors = {"Common":Color(0.541176 * 2, 0.541176 * 2, 0.541176 * 2), "Rare":Color(0, 0.2099 * 2, 0.707031 * 2), "Epic":Color(0, 0.710938 * 2, 0.027771 * 2), "Exotic":Color(0.710938 * 2, 0, 0), "Legendary":Color(0.705383 * 2, 0.710938 * 2, 0), "Exclusive":Color(0.705383 * 2, 0.710938 * 2, 0), "Premium":Color(0.705383 * 2, 0.710938 * 2, 0)}
var rec = load("res://Scenes/MainUI/Shop/Recievespawn.tscn")
var cyclepos = [Vector2( - 12, 175), Vector2(216, 175), Vector2(440, 175), Vector2(64, 388), Vector2(360, 388)]

func _ready():
	for n in 5:
		dat.append(M.get_random_miscrit())
	
	$AnimationPlayer.play("spawn")
	
	yield ($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("box")
	
	pass
var sum = - 1
func spawn():
	
	while sum <= 3:
		sum += 1
		yield (open(sum), "completed")
		
		
	
		
	$AnimationPlayer.play("congrats")
	$TextureRect / Button.disabled = false



func open(_sum):
	var recinst = rec.instance()
	$TextureRect.add_child(recinst)
	recinst.rect_position = cyclepos[_sum]
	recinst.update_bg(dat[sum])
	recinst.get_node("Label2").text = M.Miscrits_Data[str(dat[sum])]["Names"][0]
	recinst.get_node("Label").text = M.Miscrits_Data[str(dat[sum])]["Rarity"]
	recinst.get_node("Label").self_modulate = colors[M.Miscrits_Data[str(dat[sum])]["Rarity"]]
	recinst.get_node("Light2D").self_modulate = colors[M.Miscrits_Data[str(dat[sum])]["Rarity"]]
	yield (recinst.TeamAnimation, "animation_finished")
	yield (get_tree().create_timer(0.4), "timeout")
	yield (get_tree(), "idle_frame")
	
	pass

func _on_box_pressed():
	opened = true
	$AnimationPlayer.play("openbox")
	$TextureRect / box.texture = load("res://Assets/Ui/Common0.png")
	
	$TextureRect / box.rect_rotation = 0
	$TextureRect / box.rect_position = Vector2(144, 73.5)
	$TextureRect / box.rect_position.x -= 24
	$TextureRect / box.rect_position.y -= 5
	yield ($AnimationPlayer, "animation_finished")
	spawn()
	pass

func crate(array, crate):
	
	$TextureRect / info / Label2.text = "Miscrita Crate"
	dat = array
	crateid = crate
	
	return 
	
	
	
		
			
			
		
	
	
		

func _on_Clsoe_pressed():
	$AnimationPlayer.play("close")
	get_parent().queue_free()
	pass



func _on__gui_input(_event):
	if not $AnimationPlayer.current_animation == "spawn":
		
		if Input.is_action_just_released("Click"):
			if not opened:
				_on_box_pressed()
			else :
				if sum <= 3:
					sum += 1
					open(sum)
					
	pass

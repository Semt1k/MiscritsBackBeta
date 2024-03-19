extends Control
export (String) var Text = ""
export (String) var Name = ""
export (Array) var Variants = ["Bye"]
export (bool) var uiui = false
var back = {"Text":Text, "Name":Name, "Variants":Variants}






func _ready():
	$PanelContainer.rect_position.x = 480
	$PanelContainer.rect_position.y = 309
	
	pass
func generate(nodename):
	
		
		visible = true
		Name = nodename
		match Name:
			"Magicite Novice":
				
				var won = false
				if not won:
					Variants = ["Like the Forest Guard?"]
					Text = "You must be Gamer. I've been\nwaiting for you to arrive"
				else :
					Variants = ["Battle", "Bye"]
					Text = "I see, I guess you arent a noob anymore, You can go to next area! \n& oh; by the way, People from Evolia can use magic, & you travelers are relying on evolits, HAHA! \nSo you wanna fight again or what?"
			"Magicite Neophyte":
				Variants = ["Battle", "Bye"]
			"Magicite Adept":
				Variants = ["Battle", "Bye"]
		if uiui:
			$Camera2D.current = true
			
		$AnimationPlayer.play("spawn")
		start()
	
	
func start():
	add_variants()
	$PanelContainer / VBoxContainer / Control / PanelContainer2 / text.text = Name
	$PanelContainer / VBoxContainer / text.text = Text
	
	$PanelContainer / VBoxContainer / text / AnimationPlayer.play("text")
	yield ($PanelContainer / VBoxContainer / text / AnimationPlayer, "animation_finished")
	
	playbutton()
func centered():
	yield (get_tree().create_timer(0.05), "timeout")
	var sizey = $PanelContainer.rect_size.y
	var form = rect_size.y / 2 - (sizey / 2)
	$PanelContainer.rect_position.y = form
func add_variants():
	for button in $PanelContainer / VBoxContainer / buttons.get_children():
		button.queue_free()
		$PanelContainer / VBoxContainer / buttons.remove_child(button)
	for variants in Variants:
		var button = load("res://Scenes/MainUI/Answer.tscn").instance()
		button.text = variants
		button.rect_min_size.y = 36
		$PanelContainer / VBoxContainer / buttons.add_child(button)
		button.connect("pressed", self, "answer", [variants])
	pass
func back():
	Text = back["Text"]
	Name = back["Name"]
	Variants = back["Variants"]
	start()
func saveback():
	back["Text"] = Text
	back["Name"] = Name
	back["Variants"] = Variants
func answer(text):
	match Name:
		"Magicite Novice":
			match text:
				"Like the Forest Guard?":
					match Text:
						"You must be Gamer. I've been\nwaiting for you to arrive":
							Text = "No, I'm nothing like that\nsentimental fool. I've been\nwaiting for you so that i can\ndefeat you before you become	oo much of a nuisance"
							Variants = ["A nuisance to whom"]
							start()
				"A nuisance to whom":
					match Text:
						"No, I'm nothing like that\nsentimental fool. I've been\nwaiting for you so that i can\ndefeat you before you become	oo much of a nuisance":
							pass
							Text = "Apollo Nox, the most powerful\nof my people. We Magicities\nbelieve, as everyone should, that\nmagic belongs to people, not\nMiscrits."
							Variants = ["Next"]
							start()
				"Next":
					match Text:
						"Apollo Nox, the most powerful\nof my people. We Magicities\nbelieve, as everyone should, that\nmagic belongs to people, not\nMiscrits.":
							Text = "You seem to know very little of\nthe world. Have you been to the\nBattle Arena"
							Variants = ["Yes"]
							start()
				"Yes":
					match Text:
						"You seem to know very little of\nthe world. Have you been to the\nBattle Arena":
							Text = "Interesting. Well, if you've at\nleast battled there, maybe you're\nworthy of facing me."
							Variants = ["Let's fight.", "I'll be back."]
							start()
				"Let's fight.":
					match Text:
						"Interesting. Well, if you've at\nleast battled there, maybe you're\nworthy of facing me.":
							
							close()
							yield (get_tree().create_timer(0.4), "timeout")
							M.initiate_battle(Name, 0)
				"I'll be back.":
					match Text:
						"Interesting. Well, if you've at\nleast battled there, maybe you're\nworthy of facing me.":
							
							close()
		"Magicite Neophyte":
			match text:
				"Bye":
					close()
				"Battle":
					close()
					yield (get_tree().create_timer(0.4), "timeout")
					M.initiate_battle(Name, 0)
		"Magicite Adept":
			match text:
				"Bye":
					close()
				"Battle":
					close()
					yield (get_tree().create_timer(0.4), "timeout")
					M.initiate_battle(Name, 0)
					
					
					
					
					
					
							
						
							
							
					
					
					
					
					
				
					
					
							
						
						

	match text:
		"Bye":
			close()
		"Pateron":
			var _temp = OS.shell_open("https://www.patreon.com/evolits")
			pass
					

					
	pass
func time_set(cooldown, unix):
	var s = cooldown - unix
	if s < 60:
		return [s, "second(s)!"]
	
	var unit = "minute(s)!"
	var s1 = s / 60
	var ss = s % 60
	unit = "minutes(s) & " + str(ss) + " second(s)!"
	if s1 > 60:
		var s2 = s1 / 60
		ss = s1 % 60
		unit = "hour(s)! & " + str(ss) + " minutes(s)"
		return [s2, unit]
	return [s1, unit]

func playbutton():
	for button in $PanelContainer / VBoxContainer / buttons.get_children():
		button.get_node("AnimationPlayer").play("visible")
		yield (button.get_node("AnimationPlayer"), "animation_finished")
	pass
func playbuttonreverse():
	for button in $PanelContainer / VBoxContainer / buttons.get_children():
		button.get_node("AnimationPlayer").play_backwards("visible")
		
		yield (button.get_node("AnimationPlayer"), "animation_finished")
		button.visible = false
	yield (get_tree(), "idle_frame")
	pass



func close():
	yield (playbuttonreverse(), "completed")
	$PanelContainer / VBoxContainer / text / AnimationPlayer.play_backwards("text")
	
	yield ($PanelContainer / VBoxContainer / text / AnimationPlayer, "animation_finished")
	$PanelContainer / VBoxContainer / text.visible = false
	$AnimationPlayer.play_backwards("spawn")
	
	yield ($AnimationPlayer, "animation_finished")
	$PanelContainer / VBoxContainer / text.visible = false
	if uiui:
		$Camera2D.current = false
		
	visible = false
	M.player.locked_screen = false
	pass

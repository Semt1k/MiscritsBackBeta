extends TextureButton
export (String) var id = 1







func _ready():
	pass







func _on_Ability_pressed():
	if is_instance_valid(M.battle):
		M.battle._on_Ability_pressed(id, "Foe")
	pass


func _on_Ability_mouse_entered():
	if is_instance_valid(M.battle):
		if not disabled:
			M.AbiInfoCont.set_info(id)
			
			M.AbiInfoCont.rect_global_position = Vector2(rect_global_position.x - M.AbiInfoCont.rect_size.x / 2 + rect_size.x / 2, rect_global_position.y - M.AbiInfoCont.rect_size.y + 10)
			M.AbiInfoCont.rect_global_position.y -= 15
			M.AbiInfoCont.visible = true
			modulate = Color(1.2, 1.2, 1.2)
		pass

	
func _on_Ability_mouse_exited():
	if is_instance_valid(M.battle):
		M.AbiInfoCont.visible = false
		if not disabled:
			modulate = Color(1, 1, 1)
	pass
func Setup(id):
	self.get_node("Name").text = M.Abilities_Data[str(id)]["Name"]
	self.id = id
	if M.Abilities_Data[str(id)]["Type"] == "Attack" or M.Abilities_Data[str(id)]["Type"] == "Dot":
		self.get_node("Back/Element").texture = load("res://Assets/Ui/Miscrits/" + M.Abilities_Data[str(id)]["Element"] + "_Type.png")
		pass
	elif M.Abilities_Data[str(id)]["Type"] == "Buff" or M.Abilities_Data[str(id)]["Type"] == "Debuff" or M.Abilities_Data[str(id)]["Type"] == "Negate" or M.Abilities_Data[str(id)]["Type"] == "Heal":
		self.get_node("Back/Element").texture = load("res://Assets/Ui/Miscrits/" + M.Abilities_Data[str(id)]["Type"] + "_Type.png")
		if M.Abilities_Data[str(id)]["Element"][0] == "acc":
			self.get_node("Back/Element").texture = load("res://Assets/Ui/Miscrits/DebuffAcc_Type.png")
		pass
	if M.Abilities_Data[str(id)]["Type"] == "Confuse" or M.Abilities_Data[str(id)]["Type"] == "Sleep" or M.Abilities_Data[str(id)]["Type"] == "Poison":
		self.get_node("Back/Element").texture = load("res://Assets/Ui/Miscrits/Psychic_Type.png")
	if M.Abilities_Data[str(id)].has("Additional"):
		self.get_node("Back/Element").texture = load("res://Assets/Ui/Miscrits/Psychic_Type.png")
func _process(delta):
	if $Name.rect_size.y >= 58:
		$Name.rect_scale = Vector2(0.9, 0.9)

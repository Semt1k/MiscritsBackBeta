extends Control
var EnemyTeam = []



var YourTeam = []


func _ready():
	
	M.battle = self
	pass

func Data_load(data):
	var opponent_level = 0
	var dead_miscrits = []
	for add_id in M.UR_TEAM:
		var dict = M.UR_MISCRITS[add_id].duplicate(true)
		dict["GlobalId"] = add_id
		opponent_level += M.UR_MISCRITS[add_id]["Level"]
		for stat in M.Stat_names:
			dict[stat] = M.get_stat(stat, dict)
		dict["CHP"] = clamp(dict["CHP"], 0, dict["hp"])
		if dict["CHP"] >= 1:
			YourTeam.append(dict)
		else :
			dead_miscrits.append(dict)
	for dict in dead_miscrits:
		YourTeam.append(dict)
	
	opponent_level = int(round(float(opponent_level) / M.UR_TEAM.size() - 1))
	if opponent_level != 1:
		opponent_level += M.rng.randi_range( - 1, 2)
	if data["id"] == "Magicite Novice":
		opponent_level = 5
		$CanvasLayer / MainUi / Miscripedia / Capture.visible = false
	elif data["id"] == "Magicite Neophyte":
		opponent_level = 12
		$CanvasLayer / MainUi / Miscripedia / Capture.visible = false
	elif data["id"] == "Magicite Adept":
		opponent_level = 20
		$CanvasLayer / MainUi / Miscripedia / Capture.visible = false
	elif data["id"] == "Nature Elementum":
		opponent_level = 30
		$CanvasLayer / MainUi / Miscripedia / Capture.visible = false
	opponent_level = clamp(opponent_level, 1, 30)
	var dict = {"Id":str(data["id"]), "Name":"", "Level":opponent_level}
	
	for stat in M.Stat_names:
		dict[stat] = M.get_stat(stat, dict)
	if data["id"] == "Magicite Novice":
		var scale = 0.85
		var pos = 1600 - 1600 * scale
		$CanvasLayer / TextureRect.rect_scale = Vector2(scale, scale)
		$CanvasLayer / TextureRect.rect_position.y += pos * 0.125
		dict["hp"] = 81
	elif data["id"] == "Magicite Neophyte":
		var scale = 0.8
		var pos = 1600 - 1600 * scale
		$CanvasLayer / TextureRect.rect_scale = Vector2(scale, scale)
		$CanvasLayer / TextureRect.rect_position.y += pos * 0.125
		dict["hp"] = 143
	elif data["id"] == "Magicite Adept":
		var scale = 0.75
		var pos = 1600 - 1600 * scale
		$CanvasLayer / TextureRect.rect_scale = Vector2(scale, scale)
		$CanvasLayer / TextureRect.rect_position.y += pos * 0.125
		dict["hp"] = 194
	elif data["id"] == "Nature Elementum":
		var scale = 0.7
		var pos = 1600 - 1600 * scale
		$CanvasLayer / TextureRect.rect_scale = Vector2(scale, scale)
		$CanvasLayer / TextureRect.rect_position.y += pos * 0.125
		dict["hp"] = 221
		$CanvasLayer / TextureRect / TeamContainer.rect_scale = Vector2(scale, scale)
		$CanvasLayer / TextureRect / FoeContainer.rect_position.y += 100
		$CanvasLayer / TextureRect / FoeContainer.rect_position.x += 100
		$CanvasLayer / TextureRect / TeamContainer.rect_position.y += 20
	
		
	dict["CHP"] = dict["hp"]
	EnemyTeam.append(dict)
	
	Update_Abillities(Ability_Stroke)
	Battle_Switch_Update()



func Update_Abillities(stroke):
	for child in $CanvasLayer / MainUi / AbillityPanel / Abilities.get_children():
		$CanvasLayer / MainUi / AbillityPanel / Abilities.remove_child(child)
		child.queue_free()
	
	Ability_Stroke = stroke
	var keysdict = M.get_abillities_list(YourTeam[0], Ability_Stroke)[0]
	
		
		
		
		
	for id in keysdict:
		if $CanvasLayer / MainUi / AbillityPanel / Abilities.get_child_count() <= 3:
			var instance_abi = load("res://Scenes/Battle/Ability.tscn").instance()
			instance_abi.Setup(str(id))
			
			$CanvasLayer / MainUi / AbillityPanel / Abilities.add_child(instance_abi)
			
			if keysdict[ - 1] == id:
				instance_abi.texture_normal = load("res://Assets/Battle/AbilityEnd.png")
			pass
	var abi_more = $CanvasLayer / MainUi / AbillityPanel / AbillitiesMore
	var abi_less = $CanvasLayer / MainUi / AbillityPanel / AbillitiesLess
	abi_more.disabled = Ability_Stroke == 0
	abi_less.disabled = M.get_abillities_list(YourTeam[0], Ability_Stroke)[1]
	if abi_more.disabled:
		abi_more.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
	else :
		abi_more.modulate = Color(1, 1, 1, 1)
	if abi_less.disabled:
		abi_less.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
	else :
		abi_less.modulate = Color(1, 1, 1, 1)
	manage_abillity_button(false, global_button_state)
var Ability_Stroke = 0
var reverse = {"Foe":"Self", "Self":"Foe"}
func get_target(target, real_target):
	var new_target = ""
	if target != "Foe":
		if real_target == "Self":
			new_target = "Foe"
		else :
			new_target = "Self"
	else :
		if real_target == "Foe":
			new_target = "Foe"
		else :
			new_target = "Self"
	return new_target
func _on_Ability_pressed(id, target):
	manage_abillity_button(false, true)
	var AnimationPlayer_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if target == "Foe" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
	var AnimationFoe_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if target == "Self" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
	var FoeContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if target == "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
	var SelfContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if target != "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
	var link_to_foe = EnemyTeam.duplicate(false) if target == "Foe" else YourTeam.duplicate(false)
	var link_to_self = EnemyTeam.duplicate(false) if target == "Self" else YourTeam.duplicate(false)
	var hint_text = ""
	
	
	var killed = false
	if target == "Self":
		id = "1"
		var abi_select_array = M.Miscrits_Data[EnemyTeam[0]["Id"]]["Abilities"].duplicate(true)
		for ability in abi_select_array.duplicate(true):
			if ability > EnemyTeam[0]["Level"]:
				abi_select_array.erase(ability)
		abi_select_array = abi_select_array.values()
		abi_select_array.invert()
		var diff = get_elemental_diff(M.Miscrits_Data[link_to_self[0]["Id"]]["Element"], M.Miscrits_Data[link_to_foe[0]["Id"]]["Element"])
		var not_attack = not bool(M.rng.randi_range(0, 4))
		print(diff, " bot diff")
		if SelfContainer.get_node("Buffs").get_node("Negate").value_ == 1:
			diff = 1
		if diff == 2:
			for n in abi_select_array:
				n = str(n)
				
				if M.Abilities_Data[n]["Type"] == "Attack":
					if M.Abilities_Data[n]["Element"] != "Physical":
						id = n
						break
		elif diff == 1:
			for n in abi_select_array:
				n = str(n)
				if M.Abilities_Data[n]["Type"] == "Attack":
					if M.Abilities_Data[n]["Element"] == "Physical":
						id = n
						break
		elif diff == 0.5:
			print(SelfContainer.get_node("Buffs").get_node("Negate").value_)
			if SelfContainer.get_node("Buffs").get_node("Negate").value_ == 0:
				print("used negate", abi_select_array)
				for n in abi_select_array:
					n = str(n)
					if M.Abilities_Data[n]["Type"] == "Negate":
							id = n
							
							break
				if id == "1":
					for n in abi_select_array:
						n = str(n)
						if M.Abilities_Data[n]["Type"] == "Attack":
							if M.Abilities_Data[n]["Element"] == "Physical":
								id = n
								break
			else :
				if SelfContainer.get_node("Buffs").get_node("Negate").value_ >= 1:
					for n in abi_select_array:
						n = str(n)
						if M.Abilities_Data[n]["Type"] == "Attack":
							if M.Abilities_Data[n]["Element"] == "Elemental":
								id = n
								break
				else :
					for n in abi_select_array:
						n = str(n)
						if M.Abilities_Data[n]["Type"] == "Attack":
							if M.Abilities_Data[n]["Element"] == "Physical":
								id = n
								break
		if not_attack:
			print("random attack")
			var cnt = 0
			var n = "1"
			if not abi_select_array.empty():
				n = abi_select_array[M.rng.randi_range(0, abi_select_array.size() - 1)]
				while M.Abilities_Data[n]["Type"] == "Attack" and cnt <= 10:
					n = abi_select_array[M.rng.randi_range(0, abi_select_array.size() - 1)]
					if M.Abilities_Data[n]["Type"] == "Negate":
						abi_select_array.erase(n)
						
					cnt += 1
			else :
				n = "184"
			id = n
	var copiral_target = target
	if SelfContainer.get_node("Buffs").get_node("Sleep").value_ >= 1:
		yield (get_tree().create_timer(0.2), "timeout")
		SelfContainer.get_node("Buffs").get_node("Sleep").spawn_not_def(SelfContainer.get_node("Buffs").get_node("Sleep").value_ - 1)
		if target == "Self":
			manage_abillity_button(false, false)
			
		else :
			yield (get_tree().create_timer(0.4), "timeout")
			Enemy_Turn()
		return 
	
	elif SelfContainer.get_node("Buffs").get_node("Confuse").value_ >= 1:
		yield (get_tree().create_timer(0.2), "timeout")
		SelfContainer.get_node("Buffs").get_node("Confuse").spawn_not_def(SelfContainer.get_node("Buffs").get_node("Confuse").value_ - 1)
		if target == "Self":
			var new_abi = M.Miscrits_Data[YourTeam[0]["Id"]]["Abilities"].values()[M.rng.randi_range(0, M.Miscrits_Data[EnemyTeam[0]["Id"]]["Abilities"].values().size() - 1)]
			id = new_abi
			if M.rng.randi_range(1, 4) == 2:
				id = 39
			if M.rng.randi_range(1, 2) == 2:
				AnimationFoe_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if reverse[target] == "Self" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
				FoeContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if reverse[target] == "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
				link_to_foe = EnemyTeam.duplicate(false) if reverse[target] == "Foe" else YourTeam.duplicate(false)
				copiral_target = reverse[target]
			
			
		else :
			var new_abi = M.Miscrits_Data[YourTeam[0]["Id"]]["Abilities"].values()[M.rng.randi_range(0, M.Miscrits_Data[YourTeam[0]["Id"]]["Abilities"].values().size() - 1)]
			id = new_abi
			if M.rng.randi_range(1, 2) == 2:
			
				AnimationFoe_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if reverse[target] == "Self" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
				FoeContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if reverse[target] == "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
				link_to_foe = EnemyTeam.duplicate(false) if reverse[target] == "Foe" else YourTeam.duplicate(false)
				copiral_target = reverse[target]
			
		
	id = str(id)
	
		
			
	hint_text = M.Miscrits_Data[link_to_self[0]["Id"]]["Names"][0] + " uses " + M.Abilities_Data[id]["Name"]
	$CanvasLayer / MainUi / AbillityPanel / Tint / Tint.text = hint_text
	var Hit_ChanceValue = M.rng.randi_range(1, 100)
	if M.Abilities_Data[id]["Acc"] + SelfContainer.get_node("Buffs").get_node("acc").value_ > Hit_ChanceValue:
		if M.Abilities_Data[id]["Type"] == "Attack":
			var times = 1
			if M.Abilities_Data[id].has("Times"):
				times = M.Abilities_Data[id]["Times"]
			for time in times:
				killed = yield (calculate_damage(link_to_self, link_to_foe, id, time, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer, false), "completed")
		elif M.Abilities_Data[id]["Type"] == "Buff":
				yield (buff(id, copiral_target, AnimationPlayer_, SelfContainer, link_to_self, true), "completed")
		elif M.Abilities_Data[id]["Type"] == "Debuff":
				yield (debuff(copiral_target, id, AnimationPlayer_, FoeContainer, link_to_foe, true), "completed")
		elif M.Abilities_Data[id]["Type"] == "Heal":
			var WhoTarget = get_target(M.Abilities_Data[id]["Target"], copiral_target)
			yield (heal(id, WhoTarget, link_to_self, SelfContainer, AnimationPlayer_, true), "completed")
		elif M.Abilities_Data[id]["Type"] == "Sleep":
			yield (Sleep(AnimationPlayer_, copiral_target, FoeContainer, id, true), "completed")
		elif M.Abilities_Data[id]["Type"] == "Confuse":
			yield (Confuse(AnimationPlayer_, copiral_target, FoeContainer, id, true), "completed")
		elif M.Abilities_Data[id]["Type"] == "Negate":
			self_yield_animate(AnimationPlayer_)
			dam("Negate", Color(1, 0.960784, 0), reverse[copiral_target], true)
			yield (get_tree().create_timer(0.4), "timeout")
			if SelfContainer.get_node("Buffs").get_node("Negate").value_ <= 0:
				SelfContainer.get_node("Buffs").get_node("Negate").spawn_not_def(1)
			yield (get_tree().create_timer(0.4), "timeout")
		elif M.Abilities_Data[id]["Type"] == "Poison" or M.Abilities_Data[id]["Type"] == "Dot":
			yield (poison(id, copiral_target, AnimationPlayer_, SelfContainer, link_to_self, FoeContainer, M.Abilities_Data[id]["Type"], true), "completed")
		if M.Abilities_Data[id].has("Additional"):
			for addit in M.Abilities_Data[id]["Additional"]:
				var WhoTarget = get_target(M.Abilities_Data[id]["Additional"][addit]["Target"], copiral_target)
				if addit == "Sleep":
					if M.Abilities_Data[id]["Additional"][addit]["Acc"] >= M.rng.randi_range(1, 100):
						yield (Sleep(AnimationPlayer_, WhoTarget, FoeContainer, id, false), "completed")
					else :
						dam("Miss", Color(1, 1, 1), WhoTarget)
						yield (get_tree().create_timer(0.4), "timeout")
				if addit == "Confuse":
					if M.Abilities_Data[id]["Additional"][addit]["Acc"] >= M.rng.randi_range(1, 100):
						yield (Confuse(AnimationPlayer_, copiral_target, FoeContainer, id, false), "completed")
					else :
						dam("Miss", Color(1, 1, 1), WhoTarget)
						yield (get_tree().create_timer(0.4), "timeout")
				if addit == "Heal":
					if M.Abilities_Data[id]["Additional"][addit]["Acc"] >= M.rng.randi_range(1, 100):
						yield (heal(id, WhoTarget, link_to_self, SelfContainer, AnimationPlayer_, false), "completed")
					else :
						dam("Miss", Color(1, 1, 1), WhoTarget)
						yield (get_tree().create_timer(0.4), "timeout")
				if addit == "Buff":
					yield (buff(M.Abilities_Data[id]["Additional"][addit], copiral_target, AnimationPlayer_, SelfContainer, link_to_self, false), "completed")
				if addit == "Debuff":
					yield (debuff(copiral_target, id, AnimationPlayer_, FoeContainer, link_to_foe, false), "completed")
				if addit == "Poison" or addit == "Dot":
					yield (poison(id, copiral_target, AnimationPlayer_, SelfContainer, link_to_self, FoeContainer, addit, false), "completed")
	else :
		self_yield_animate(AnimationPlayer_)
		dam("Miss", Color(1, 1, 1), copiral_target)
		yield (get_tree().create_timer(0.4), "timeout")
	if not killed:
		killed = yield (ManageOverTurn(link_to_self, link_to_foe, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer), "completed")
	else :
		killed = yield (ManageOverTurn(link_to_self, link_to_foe, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer), "completed")
		killed = true
	Update_Capture_Precent()
	AnimationFoe_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if target == "Self" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
	FoeContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if target == "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
	link_to_foe = EnemyTeam.duplicate(false) if target == "Foe" else YourTeam.duplicate(false)
	if not killed:
		if target == "Self":
			if FoeContainer.get_node("Buffs").get_node("Sleep").value_ >= 1:
				
				yield (get_tree().create_timer(0.5), "timeout")
				
				_on_Ability_pressed(1, "Foe")
			elif FoeContainer.get_node("Buffs").get_node("Confuse").value_ >= 1:
				
				yield (get_tree().create_timer(0.5), "timeout")
				
				_on_Ability_pressed(1, "Foe")
			else :
				
				yield (get_tree().create_timer(0.5), "timeout")
				manage_abillity_button(false, false)
		else :
			
			manage_abillity_button(false, true)
			yield (get_tree().create_timer(0.5), "timeout")
			Enemy_Turn()
	else :
		var dead = true
		var dead_self = true
		for check in link_to_foe.size():
			if link_to_foe[check]["CHP"] >= 1:
				dead = false
				Switch_Miscrit(check, target, true)
				break
		if dead:
			
			AnimationFoe_.play("Faint")
			yield (get_tree().create_timer(1.4), "timeout")
			close_battle(target)
			
	Battle_Switch_Update()
	yield (get_tree(), "idle_frame")

func heal(id, WhoTarget, link_to_self, SelfContainer, AnimationPlayer_, main):
	var value = 0
	if main:
		value = M.Abilities_Data[id]["AP"]
		self_yield_animate(AnimationPlayer_)
	else :
		value = M.Abilities_Data[id]["Additional"]["Heal"]["AP"]
	dam("+" + str(value) + " Health", Color(0, 1, 0), WhoTarget)
	
	link_to_self[0]["CHP"] += value
	link_to_self[0]["CHP"] = clamp(link_to_self[0]["CHP"], 0, link_to_self[0]["hp"])
	SelfContainer.Receive_damage(value, link_to_self[0]["CHP"])
	yield (get_tree().create_timer(0.4), "timeout")
	yield (get_tree(), "idle_frame")
	pass
func poison(id, copiral_target, AnimationPlayer_, SelfContainer, link_to_self, FoeContainer, type, main):
	var metadata = {}
	var turns = 1
	var Name = "Jopa"
	var Type = type
	if main:
		metadata = M.Abilities_Data[id]
		turns = M.Abilities_Data[id]["Turns"]
		Name = M.Abilities_Data[id]["Name"]
		Type = M.Abilities_Data[id]["Type"]
		metadata["Type"] = Type
		
		self_yield_animate(AnimationPlayer_)
	else :
		metadata = M.Abilities_Data[id]["Additional"][type]
		turns = M.Abilities_Data[id]["Additional"][type]["Turns"]
		Name = M.Abilities_Data[id]["Name"]
		Type = type
	if Type == "Dot":
		metadata["Element"] = M.Abilities_Data[id]["Element"]
	if FoeContainer.get_node("Buffs").has_node(Name):
		dam(Name, Color(1, 0.960784, 0), copiral_target, true)
		yield (get_tree().create_timer(0.25), "timeout")
		FoeContainer.get_node("Buffs").get_node(Name).spawn_not_def(turns)
		FoeContainer.get_node("Buffs").get_node(Name).metadata = metadata
		yield (get_tree().create_timer(0.45), "timeout")
	else :
		dam(Name, Color(1, 0.960784, 0), copiral_target, true)
		yield (get_tree().create_timer(0.25), "timeout")
		var ins = load("res://Scenes/Battle/Battle_Buff.tscn").instance()
		ins.name = Name
		ins.type = Type
		ins.visible = false
		FoeContainer.get_node("Buffs").add_child(ins)
		ins.spawn_not_def(turns)
		ins.metadata = metadata
	yield (get_tree().create_timer(0.45), "timeout")
	yield (get_tree(), "idle_frame")
func debuff(copiral_target, id, AnimationPlayer_, FoeContainer, link_to_foe, main):
	var abi_target = "Self"
	var value = 1
	var element = ["ea"]
	if main:
		self_yield_animate(AnimationPlayer_)
		abi_target = M.Abilities_Data[id]["Target"]
		value = M.Abilities_Data[id]["AP"]
		element = M.Abilities_Data[id]["Element"]
	else :
		abi_target = M.Abilities_Data[id]["Additional"]["Debuff"]["Target"]
		value = M.Abilities_Data[id]["Additional"]["Debuff"]["AP"]
		element = M.Abilities_Data[id]["Additional"]["Debuff"]["Element"]
	var WhoTarget = get_target(abi_target, copiral_target)
	for key_buff in element:
		pass
		FoeContainer.get_node("Buffs").get_node(key_buff).spawn( - value)
		if link_to_foe[0].has(key_buff):
			link_to_foe[0][key_buff] -= value
	
	if element.size() == 1:
		dam(M.Buffs_Linker[element[0]] + " - " + str(value), Color(1, 1, 1), WhoTarget, true)
	elif element.size() == 2:
		if element.has("ea") and element.has("pa"):
			dam("Both Attacks - " + str(value), Color(1, 1, 1), WhoTarget, true)
		if element.has("ed") and element.has("pd"):
			dam("Both Defences - " + str(value), Color(1, 1, 1), WhoTarget, true)
	yield (get_tree().create_timer(0.4), "timeout")
	yield (get_tree(), "idle_frame")
func buff(id, copiral_target, AnimationPlayer_, SelfContainer, link_to_self, main):
	var abi_target = "Self"
	var value = 1
	var element = ["ea"]
	if main:
		self_yield_animate(AnimationPlayer_)
		abi_target = M.Abilities_Data[id]["Target"]
		value = M.Abilities_Data[id]["AP"]
		element = M.Abilities_Data[id]["Element"]
	else :
		abi_target = id["Target"]
		value = id["AP"]
		element = id["Element"]
	var WhoTarget = get_target(abi_target, copiral_target)
	for key_buff in element:
		pass
		SelfContainer.get_node("Buffs").get_node(key_buff).spawn(value)
		if link_to_self[0].has(key_buff):
			link_to_self[0][key_buff] += value
	
	if element.size() == 1:
		dam(M.Buffs_Linker[element[0]] + " + " + str(value), Color(1, 1, 1), WhoTarget, true)
	elif element.size() == 2:
		if element.has("ea") and element.has("pa"):
			dam("Both Attacks + " + str(value), Color(1, 1, 1), WhoTarget, true)
		if element.has("ed") and element.has("pd"):
			dam("Both Defences + " + str(value), Color(1, 1, 1), WhoTarget, true)
	yield (get_tree().create_timer(0.4), "timeout")
	yield (get_tree(), "idle_frame")
func Confuse(AnimationPlayer_, copiral_target, FoeContainer, id, main):
	var turns = 0
	if main:
		self_yield_animate(AnimationPlayer_)
		turns = M.Abilities_Data[id]["AP"]
	else :
		turns = M.Abilities_Data[id]["Additional"]["Confuse"]["AP"]
	dam("Confuse", Color(1, 0.960784, 0), copiral_target, true)
	yield (get_tree().create_timer(0.4), "timeout")
	if FoeContainer.get_node("Buffs").get_node("Confuse").value_ <= 0:
		FoeContainer.get_node("Buffs").get_node("Confuse").spawn_not_def(turns)
	else :
		dam("Imunne!", Color(1, 1, 1), copiral_target, true)
	yield (get_tree().create_timer(0.4), "timeout")
	yield (get_tree(), "idle_frame")
func Sleep(AnimationPlayer_, copiral_target, FoeContainer, id, main):
	var turns = 0
	var yield_time = 0.4
	if main:
		self_yield_animate(AnimationPlayer_)
		turns = M.Abilities_Data[id]["AP"]
	else :
		yield_time = 0.0
		turns = M.Abilities_Data[id]["Additional"]["Sleep"]["AP"]
	dam("Sleep", Color(1, 0.960784, 0), copiral_target, true)
	yield (get_tree().create_timer(yield_time), "timeout")
	if FoeContainer.get_node("Buffs").get_node("Sleep").value_ <= 0:
		FoeContainer.get_node("Buffs").get_node("Sleep").spawn_not_def(turns)
	else :
		dam("Imunne!", Color(1, 1, 1), copiral_target, true)
	yield (get_tree().create_timer(yield_time), "timeout")
	yield (get_tree(), "idle_frame")




func calculate_damage(link_to_self, link_to_foe, id, time, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer, afterturn):
	var damage = 0
	var damage_x = 1
	if not afterturn:
		damage_x = get_elemental_diff(M.Miscrits_Data[link_to_self[0]["Id"]]["Element"], M.Miscrits_Data[link_to_foe[0]["Id"]]["Element"])
		if FoeContainer.get_node("Buffs").get_node("Negate").value_ >= 1 and damage_x == 2:
			damage_x = 1
		elif SelfContainer.get_node("Buffs").get_node("Negate").value_ >= 1 and damage_x == 0.5:
			damage_x = 1
		var crit = 1
		var ea = clamp(link_to_self[0]["ea"], 5, 1000000)
		var pa = clamp(link_to_self[0]["pa"], 5, 1000000)
		var ed = clamp(link_to_foe[0]["ed"], 5, 10000000)
		var pd = clamp(link_to_foe[0]["pd"], 5, 1000000)
		damage = int(round(float(crit) * (float(float(ea) * float(M.Abilities_Data[id]["AP"])) / float(ed)) * float(damage_x)) + M.rng.randi_range( - 1, 1))
		if M.Abilities_Data[id]["Element"] == "Physical":
			damage_x = 1
			damage = int(round(float(crit) * (float(float(pa) * float(M.Abilities_Data[id]["AP"])) / float(pd)) * float(damage_x)) + M.rng.randi_range( - 1, 1))
	else :
		if id["Type"] == "Poison":
			damage = id["AP"] + M.rng.randi_range( - 1, 1)
		else :
			if FoeContainer.get_node("Buffs").get_node("Negate").value_ >= 1 and damage_x == 2:
				damage_x = 1
			elif SelfContainer.get_node("Buffs").get_node("Negate").value_ >= 1 and damage_x == 0.5:
				damage_x = 1
			var crit = 1
			var ea = clamp(link_to_self[0]["ea"], 5, 1000)
			var pa = clamp(link_to_self[0]["pa"], 5, 1000)
			var ed = clamp(link_to_foe[0]["ed"], 5, 1000)
			var pd = clamp(link_to_foe[0]["pd"], 5, 1000)
			damage = int(round(float(crit) * (float(float(ea) * float(id["AP"])) / float(ed)) * float(damage_x)) + M.rng.randi_range( - 1, 1))
		pass
	damage = clamp(damage, 1, 100000)
	var killed = false
	link_to_foe[0]["CHP"] -= damage
	link_to_foe[0]["CHP"] = clamp(link_to_foe[0]["CHP"], 0, 220)
	if time == 0:
		self_yield_animate(AnimationPlayer_)
	dam("-" + str(damage), Color(1, 0, 0), copiral_target)
	if FoeContainer.get_node("Buffs").get_node("Sleep").value_ >= 1:
		yield (get_tree().create_timer(0.07), "timeout")
		FoeContainer.get_node("Buffs").get_node("Sleep").spawn_not_def(0)
		dam("Woke Up!", Color(1, 1, 1), copiral_target, true)
	
	if damage_x == 2:
		yield (get_tree().create_timer(0.2), "timeout")
		dam("critical", Color(1, 1, 1), copiral_target)
	elif damage_x == 0.5:
		yield (get_tree().create_timer(0.2), "timeout")
		dam("weak!", Color(1, 1, 1), copiral_target)
	if link_to_foe[0]["CHP"] <= 0:
		killed = true
	
	FoeContainer.Receive_damage(damage, link_to_foe[0]["CHP"])
	
	yield (get_tree().create_timer(0.4), "timeout")
	
	yield (get_tree(), "idle_frame")
	return killed
func ManageOverTurn(link_to_self, link_to_foe, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer):
	var killed = false
	for poison_damage in FoeContainer.get_node("Buffs").get_children():
		if poison_damage.value_ >= 1:
			if poison_damage.type == "Poison" or poison_damage.type == "Dot":
				
				poison_damage.spawn_not_def(poison_damage.value_ - 1)
				killed = yield (calculate_damage(link_to_self, link_to_foe, poison_damage.metadata, 1, copiral_target, FoeContainer, AnimationPlayer_, AnimationFoe_, SelfContainer, true), "completed")
	yield (get_tree(), "idle_frame")
	return killed
func Switch_Miscrit(id, target, faint):
	
	var AnimationPlayer_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if target == "Foe" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
	var AnimationFoe_ = $CanvasLayer / TextureRect / TeamContainer / AnimationPlayer if target == "Self" else $CanvasLayer / TextureRect / FoeContainer / AnimationPlayer
	var FoeContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if target == "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
	var SelfContainer = $CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer if target != "Foe" else $CanvasLayer / MainUi / Our / MiscritInfoContainer
	var link_to_foe = EnemyTeam.duplicate(false) if target == "Foe" else YourTeam.duplicate(false)
	var link_to_self = EnemyTeam.duplicate(false) if target == "Self" else YourTeam.duplicate(false)
	if target == "Self":
		manage_abillity_button(false, true)
		if faint:
			AnimationFoe_.play("Faint")
		else :
			AnimationFoe_.play("Return")
		yield (AnimationFoe_, "animation_finished")
		var new_your_team = []
		new_your_team.append(YourTeam[id])
		YourTeam.remove(id)
		for add in YourTeam:
			new_your_team.append(add)
		YourTeam = new_your_team
		var letter = M.get_evolution(YourTeam[0])
		$CanvasLayer / TextureRect / TeamContainer / Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + YourTeam[0]["Id"] + letter + ".png")
		
		Update_Abillities(0)
		_on_TabSwitch_pressed("Abilities")
		
		
		
		Update_OurFoePanels()
		yield (get_tree().create_timer(0.0), "timeout")
		$CanvasLayer / MainUi / Our.get_child(0).clean()
		$CanvasLayer / MainUi / Our.get_child(0).get_node("HealthBar").setup(YourTeam[0]["CHP"], YourTeam[0]["hp"])
		AnimationFoe_.play("Spawn")
		yield (AnimationFoe_, "animation_finished")
		AnimationFoe_.play("Breath")
		yield (ManageOverTurn(link_to_foe, link_to_self, "Foe", SelfContainer, AnimationFoe_, AnimationPlayer_, SelfContainer), "completed")
		yield (get_tree().create_timer(0.4), "timeout")
		if YourTeam[0]["spd"] > EnemyTeam[0]["spd"]:
			if sniper != "Self":
				sniper = "Self"
				manage_abillity_button(false, false)
			else :
				Enemy_Turn()
		else :
			if sniper != "Foe":
				sniper = "Foe"
				Enemy_Turn()
			else :
				manage_abillity_button(false, false)
		
	pass
var sniper = ""
var sniped = false
func self_yield_animate(AnimationPlayer_):
	AnimationPlayer_.play("Puchuk")
	yield (AnimationPlayer_, "animation_finished")
	AnimationPlayer_.play("Breath")
var damage_scene = load("res://Scenes/Battle/Damage.tscn")
func dam(text, colour, target, small = false):
	var dam = damage_scene.instance()
	dam.text = str(text)
	
	
	
	
	dam.small = small
	dam.modulate = colour
	if target == "Foe":
		$CanvasLayer / TextureRect / FoeContainer.add_child(dam)
	else :
		$CanvasLayer / TextureRect / TeamContainer.add_child(dam)
		
func close_battle(who):
	$AnimationPlayer.play("exit")
	yield (get_tree().create_timer(0.5), "timeout")
	$AnimationPlayer.play("spawn_result")
	$CanvasLayer / Result.visible = true
	M.Background_Music.playing = true
	var exp_for_each = int(float(get_xp_reward()) / YourTeam.size() - 1)
	
	$CanvasLayer / Result.visible = true
	for evolit_data in YourTeam.size():
		var data = YourTeam[evolit_data]
		var result_scene = load("res://Scenes/Battle/ResultIcon.tscn").instance()
		$CanvasLayer / Result / Panel / YourTeam / Grid.add_child(result_scene)
		result_scene.get_node("IconPanel/Icon").update_icon(data)
		result_scene.get_node("HealthBar").setup(data["CHP"], data["hp"])
		result_scene.get_node("XPBar").maxx = M.UR_MISCRITS[data["GlobalId"]]["Level"] == 30
		result_scene.get_node("XPBar").setup(M.UR_MISCRITS[data["GlobalId"]]["CXP"], M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
		if who == "Foe" and data["Level"] != 30:
			if M.UR_MISCRITS[data["GlobalId"]]["CXP"] != M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1]:
				result_scene.get_node("XPBar").Animation_Tween(M.UR_MISCRITS[data["GlobalId"]]["CXP"], exp_for_each, M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
			result_scene.get_node("ExpLabel").text = "+" + str(exp_for_each) + "xp"
			result_scene.get_node("ExpLabel/AnimationPlayer").play("Spawn")
	if who == "Foe":
		var ins = load("res://Scenes/Battle/Reward.tscn").instance()
		ins.get_node("HBoxContainer/value").text = str(int(clamp(EnemyTeam[0]["Level"] / 1.3, 1, 20)))
		M.Gold += int(clamp(EnemyTeam[0]["Level"] / 1.3, 1, 20))
		$CanvasLayer / Result / Panel / Reward / HBoxContainer.add_child(ins)
	for evolit_data in EnemyTeam.size():
		var data = EnemyTeam[evolit_data]
		var result_scene = load("res://Scenes/Battle/ResultIcon.tscn").instance()
		if evolit_data == 0:
			if captured:
				result_scene.get_node("Captured").visible = true
		result_scene.get_node("IconPanel/Icon").update_icon(data)
		result_scene.get_node("IconPanel/Icon").texture = load("res://Assets/Miscrits/Icons/" + str(data["Id"]) + "a.png")
		result_scene.type = 1
		result_scene.get_node("HealthBar").setup(data["CHP"], data["hp"])
		
		$CanvasLayer / Result / Panel / EnemyTeam / Grid.add_child(result_scene)
		if M.Miscrits_Data[data["Id"]].has("Quest") and who == "Foe":
			M.add_quest(M.Miscrits_Data[data["Id"]]["Quest"])
			M.location.get_node("Screen/Magicite Novice")._ready()
			M.location.get_node("Screen/NPC3")._ready()
			M.location.get_node("Screen/NPC")._ready()
	for Update in YourTeam.size():
		var dict = YourTeam[Update]
		M.UR_MISCRITS[dict["GlobalId"]]["CHP"] = dict["CHP"]
		if who == "Foe":
			M.UR_MISCRITS[dict["GlobalId"]]["CXP"] += exp_for_each
	
func _on_Run_pressed():
	close_battle("Self")
	pass
func Update_OurFoePanels():
	
	
	for evolit in YourTeam.size():
		$CanvasLayer / MainUi / Our.get_child(evolit).Setup(YourTeam[evolit])
		
		
	$CanvasLayer / MainUi / Foe / FoeMiscritInfoContainer.Setup(EnemyTeam[0])
func Spawn(data):
	
	$AudioStreamPlayer.stream = load("res://Assets/Sound/Forest_Battle.ogg")
	$AudioStreamPlayer.play()
	manage_abillity_button(false, true)
	
	
	Update_OurFoePanels()
	$AnimationPlayer.play_backwards("exit")
	
	yield (get_tree().create_timer(1.1), "timeout")
	var letter = M.get_evolution(YourTeam[0])
	$CanvasLayer / TextureRect / TeamContainer / Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + YourTeam[0]["Id"] + letter + ".png")
	letter = M.get_evolution(EnemyTeam[0])
	$CanvasLayer / TextureRect / FoeContainer / Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + EnemyTeam[0]["Id"] + "a.png")
	$CanvasLayer / TextureRect / TeamContainer / AnimationPlayer.play("Spawn")
	yield ($CanvasLayer / TextureRect / TeamContainer / AnimationPlayer, "animation_finished")
	$CanvasLayer / TextureRect / TeamContainer / AnimationPlayer.play("Breath")
	yield (get_tree().create_timer(0.2), "timeout")
	$CanvasLayer / TextureRect / FoeContainer / AnimationPlayer.play("Spawn")
	yield ($CanvasLayer / TextureRect / FoeContainer / AnimationPlayer, "animation_finished")
	$CanvasLayer / TextureRect / FoeContainer / AnimationPlayer.play("Breath")
	yield (get_tree().create_timer(0.3), "timeout")
	if YourTeam[0]["spd"] > EnemyTeam[0]["spd"]:
		
		manage_abillity_button(false, false)
	elif YourTeam[0]["spd"] < EnemyTeam[0]["spd"]:
		yield (_on_Ability_pressed(1, "Self"), "completed")
		
	else :
		
		yield (_on_Ability_pressed(1, "Self"), "completed")
		pass
	Update_Capture_Precent()
	$CanvasLayer / MainUi / Miscripedia / Capture / Panel.visible = true
func Enemy_Turn():
	_on_Ability_pressed(1, "Self")
	pass
var global_button_state = true
func manage_abillity_button(array, state):
	global_button_state = state
	if array is Array:
		pass
	else :
		var nodes = $CanvasLayer / MainUi / AbillityPanel / Abilities.get_children()
		nodes.append($CanvasLayer / MainUi / Run)
		nodes.append($CanvasLayer / MainUi / Miscripedia / Capture)
		nodes += $CanvasLayer / MainUi / AbillityPanel / Miscrits.get_children()
		for child in nodes:
			if child.get("disabled") != null:
				child.disabled = state
			else :
				child.get_node("click").disabled = state
			if state:
				child.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
			else :
				child.modulate = Color(1, 1, 1)
func get_elemental_diff(aEle, oEle):
	match aEle:
		"Fire":
			if "Nature" in oEle:
				return 2
			elif "Water" in oEle:
				return 0.5
		"Water":
			if "Fire" in oEle:
				return 2
			elif "Nature" in oEle:
				return 0.5
		"Nature":
			if "Fire" in oEle:
				return 0.5
			elif "Water" in oEle:
				return 2
		"Wind":
			if "Earth" in oEle:
				return 2
			elif "Lightning" in oEle:
				return 0.5
		"Lightning":
			if "Wind" in oEle:
				return 2
			elif "Earth" in oEle:
				return 0.5
		"Earth":
			if "Wind" in oEle:
				return 0.5
			elif "Lightning" in oEle:
				return 2
	return 1

func get_xp_reward():
	var total_exp = 0
	for evolit in EnemyTeam.size():
		var value = float(M.EXP_NEED_TO_LEVEL_UP[EnemyTeam[evolit]["Level"]] / (1 + (int(float(EnemyTeam[evolit]["Level"]) / 4)))) + 10
		value += M.rng.randf_range(1, value / 10)
		total_exp += int(value)
	return total_exp * 3
func _on_Close_pressed():
	M.Main_Ui.update_values()
	BackgroundLoad.Fake_Loading()
	yield (get_tree().create_timer(0.5), "timeout")
	self.queue_free()
	pass


func _on_OpenOurMiscritsFull_mouse_entered():
	$CanvasLayer / MainUi / Our.get_child(0).get_node("Buffs").visible = false
	for evolit in YourTeam.size():
		$CanvasLayer / MainUi / Our.get_child(evolit).Setup(YourTeam[evolit])
		$CanvasLayer / MainUi / Our.get_child(evolit).visible = true
	
	
	

	
	
	pass
var percent = 0
func Update_Capture_Precent():
	percent = clamp(int(100 - (EnemyTeam[0]["CHP"] / EnemyTeam[0]["hp"] * 70)), 1, 100)
	$CanvasLayer / MainUi / Miscripedia / Capture / Panel / Percent.text = str(percent) + "%"

func _on_OpenOurMiscritsFull_mouse_exited():
	$CanvasLayer / MainUi / Our.get_child(0).get_node("Buffs").visible = true
	for evolit in YourTeam.size():
		if evolit != 0:
			$CanvasLayer / MainUi / Our.get_child(evolit).Setup(YourTeam[evolit])
			$CanvasLayer / MainUi / Our.get_child(evolit).visible = false
	
	
	
	
		
		
	pass


func _on_AbillitiesMore_pressed():
	Update_Abillities(Ability_Stroke - 1)
	


func _on_AbillitiesLess_pressed():
	
	Update_Abillities(Ability_Stroke + 1)
	
	pass


func _on_Capture_pressed():
	$AnimationPlayer.play("Capture")

	manage_abillity_button(false, true)
	yield (get_tree().create_timer(1.7), "timeout")
	

	if M.rng.randi_range(1, 100) >= percent:
		dam("FAILED, WHAT A LOSER!!!!", Color(1, 1, 1), $CanvasLayer / TextureRect / FoeContainer)
		yield (get_tree().create_timer(1.0), "timeout")
		Enemy_Turn()
	else :
		$CanvasLayer / TextureRect / FoeContainer.get_node("AnimationPlayer").play("Captured")
		yield (get_tree().create_timer(2.5), "timeout")
		$AudioStreamPlayer.stream = load("res://Assets/Sound/Capture.ogg")
		$AudioStreamPlayer.playing = true
		captured = true
		
		M.add_new_Miscrit(EnemyTeam[0]["Id"])
		$CanvasLayer / Captured / AnimationPlayer.play("Spawn")
		$CanvasLayer / Captured / Captured / Pedia / Evolit.texture = load("res://Assets/Miscrits/Miscrits/" + str(EnemyTeam[0]["Id"]) + "a.png")
		$CanvasLayer / Captured / Captured / Name.text = M.Miscrits_Data[EnemyTeam[0]["Id"]]["Names"][0]
		
	pass
var captured = false


func _on_Captured_Continue_pressed():
	$CanvasLayer / Captured / AnimationPlayer.play("Close")
	yield ($CanvasLayer / Captured / AnimationPlayer, "animation_finished")
	close_battle("Self")
	pass

func _on_TabSwitch_pressed(extra_arg_0):
	for pres in $CanvasLayer / MainUi / AbillityPanel / TabsContainer.get_children():
		pres.pressed = false
	var node = $CanvasLayer / MainUi / AbillityPanel / TabsContainer.get_node(extra_arg_0)
	if not node.pressed:
		node.pressed = true
	var nodesarr = ["Abilities", "Miscrits"]
	for vis in nodesarr:
		$CanvasLayer / MainUi / AbillityPanel.get_node(vis).visible = false
	$CanvasLayer / MainUi / AbillityPanel / AbillitiesMore.visible = extra_arg_0 == "Abilities"
	$CanvasLayer / MainUi / AbillityPanel / AbillitiesLess.visible = extra_arg_0 == "Abilities"
	$CanvasLayer / MainUi / AbillityPanel.get_node(extra_arg_0).visible = true
	pass

func Battle_Switch_Update():
	for child in $CanvasLayer / MainUi / AbillityPanel / Miscrits.get_children():
		$CanvasLayer / MainUi / AbillityPanel / Miscrits.remove_child(child)
		child.queue_free()
	for id in M.UR_TEAM:
		var data = M.UR_MISCRITS[id]
		var battle_data = null
		for battle_miscrit in YourTeam:
			if battle_miscrit.GlobalId == id:
				battle_data = battle_miscrit.duplicate(true)
		var instance = load("res://Scenes/Battle/BattleSwitchContainer.tscn").instance()
		instance.Setup(data, battle_data)
		if global_button_state:
			instance.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
		else :
			instance.modulate = Color(1, 1, 1)
		instance.get_node("click").disabled = global_button_state
		$CanvasLayer / MainUi / AbillityPanel / Miscrits.add_child(instance)


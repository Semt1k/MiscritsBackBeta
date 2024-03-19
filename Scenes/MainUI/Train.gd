extends Control
var CurrentID = null
var old_node = null






func _ready():
	M.Train = self
	pass





func Update(id, full = true):
	var array = M.UR_MISCRITS[id]
	Update_Abillities(array, 0)
	var letter = M.get_evolution(array)
	if full == true:
		Update_Miscrits()
	
	CurrentID = id
	if is_instance_valid(old_node):
		old_node.texture_normal = load("res://Assets/Ui/TrainingMiscrit_NonTeam.png")
	if $TextureRect / Team / VBoxContainer.has_node(str(CurrentID)):
		old_node = $TextureRect / Team / VBoxContainer.get_node(str(CurrentID))
	else :
		old_node = $TextureRect / All / VBoxContainer.get_node(str(CurrentID))
	Update_Stats()
		
			
	
	
	$TextureRect / Background.texture = load("res://Assets/Ui/TrainBackground/" + str(M.Miscrits_Data[M.UR_MISCRITS[CurrentID]["Id"]]["Element"]) + ".png")
	$TextureRect / MaxEvolution.visible = M.UR_MISCRITS[CurrentID]["Level"] == 30
	$TextureRect / Evolve.visible = not $TextureRect / MaxEvolution.visible
	$TextureRect / Train.visible = not $TextureRect / MaxEvolution.visible
	$TextureRect / Background / TeamContainer / Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + array["Id"] + letter + ".png")
	$TextureRect / Background / TeamContainer / AnimationPlayer.play("SpawnNoSound")
	yield ($TextureRect / Background / TeamContainer / AnimationPlayer, "animation_finished")
	$TextureRect / Background / TeamContainer / AnimationPlayer.play("Breath")
func Update_Stats():
	
	
		
	for stats in M.Stat_names:
		$TextureRect / AbilitiesPanel / PanelStats / Stats.get_node(stats).get_node("Value").text = str(M.get_stat(stats, M.UR_MISCRITS[CurrentID]))
		
func Update_Miscrits():
	for remove in $TextureRect / Team / VBoxContainer.get_children():
		$TextureRect / Team / VBoxContainer.remove_child(remove)
		remove.queue_free()
	for IDS in M.UR_TEAM:
		var data = M.UR_MISCRITS[IDS]
		var instance = M.MiscritTrain.instance()
		instance.get_node("IconPanel/Icon").update_icon(data)
		instance.get_node("Name").text = str(data["Name"] if data["Name"] != "" else M.Miscrits_Data[M.UR_MISCRITS[IDS]["Id"]]["Names"][0])
		instance.id = IDS
		instance.name = str(IDS)
		instance.get_node("IconElement/Element").texture = load("res://Assets/Ui/Miscrits/" + M.Miscrits_Data[M.UR_MISCRITS[IDS]["Id"]]["Element"] + "_Type.png")
		instance.get_node("XPBar").maxx = data["Level"] == 30
		instance.get_node("XPBar").setup(data["CXP"], M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
		$TextureRect / Team / VBoxContainer.add_child(instance)
	while $TextureRect / Team / VBoxContainer.get_child_count() <= 3:
		var ins = M.MiscritEmpty.instance()
		$TextureRect / Team / VBoxContainer.add_child(ins)
	update_other()
func Update_Miscrits_Unique(id):
	
	
		
	for instance in $TextureRect / Team / VBoxContainer.get_children():
		if instance.get("id") != null and instance.id == id:
			var data = M.UR_MISCRITS[id]
			instance.get_node("IconPanel/Icon").update_icon(data)
			instance.get_node("Name").text = str(data["Name"])
			
			
			instance.get_node("XPBar").setup(data["CXP"], M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
			break
	for instance in $TextureRect / All / VBoxContainer.get_children():
		if instance.get("id") != null and instance.id == id:
			var data = M.UR_MISCRITS[id]
			instance.get_node("IconPanel/Icon").update_icon(data)
			instance.get_node("Name").text = str(data["Name"])
			
			
			instance.get_node("XPBar").setup(data["CXP"], M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
			break
		
	
func Update_Abillities(array, stroke):
	for child in $TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.get_children():
		$TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.remove_child(child)
		child.queue_free()
	
	Ability_Stroke = stroke
	var keysdict = M.get_abillities_list(array, Ability_Stroke)[0]
	
		
		
		
		
	for id in keysdict:
		if $TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.get_child_count() <= 3:
			var instance_abi = load("res://Scenes/Battle/Ability.tscn").instance()
			instance_abi.Setup(str(id))
			
			$TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.add_child(instance_abi)
			
			if $TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.get_child_count() == 4 or $TextureRect / AbilitiesPanel / AbilitiesPanel / GridContainer.get_child_count() == 2 or keysdict[ - 1] == id:
				instance_abi.texture_normal = load("res://Assets/Battle/AbilityEnd.png")
	var abi_more = $TextureRect / AbilitiesPanel / AbillitiesMore
	var abi_less = $TextureRect / AbilitiesPanel / AbillitiesLess
	abi_more.disabled = Ability_Stroke == 0
	abi_less.disabled = M.get_abillities_list(array, stroke)[1]
	if abi_more.disabled:
		abi_more.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
	else :
		abi_more.modulate = Color(1, 1, 1, 1)
	if abi_less.disabled:
		abi_less.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
	else :
		abi_less.modulate = Color(1, 1, 1, 1)
	
	
var Ability_Stroke = 0
func _on_Train_visibility_changed():
	M.Background_Music.playing = not visible
	$AudioStreamPlayer.playing = visible
	if visible == true:
		stroke = 0
		$AnimationPlayer.play("Spawn")
		Update(M.UR_TEAM[0])
		Update_Miscrits()
	pass
var stroke = 0
func update_other():
	for remove in $TextureRect / All / VBoxContainer.get_children():
		$TextureRect / All / VBoxContainer.remove_child(remove)
		remove.queue_free()
	var evo_less = $TextureRect / All / OtherLess
	evo_less.disabled = true
	evo_less.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843)
	var array_other_evos = M.UR_MISCRITS.keys().duplicate(true)
	array_other_evos.sort_custom(M.MyCustomSorter, "sort_ascending")
	
	
	for rem in M.UR_TEAM:
		array_other_evos.erase(rem)
	for pop in stroke:
		array_other_evos.pop_front()
	while array_other_evos.size() >= 7:
		array_other_evos.pop_back()
		evo_less.disabled = false
		evo_less.modulate = Color(1, 1, 1, 1)
	for IDS in array_other_evos:
		var data = M.UR_MISCRITS[IDS]
		var instance = M.MiscritTrain.instance()
		instance.get_node("IconPanel/Icon").update_icon(data)
		instance.get_node("Name").text = str(data["Name"] if data["Name"] != "" else M.Miscrits_Data[M.UR_MISCRITS[IDS]["Id"]]["Names"][0])
		instance.id = IDS
		instance.name = str(IDS)
		instance.get_node("IconElement/Element").texture = load("res://Assets/Ui/Miscrits/" + M.Miscrits_Data[M.UR_MISCRITS[IDS]["Id"]]["Element"] + "_Type.png")
		instance.get_node("XPBar").maxx = data["Level"] == 30
		instance.get_node("XPBar").setup(data["CXP"], M.EXP_NEED_TO_LEVEL_UP[data["Level"] + 1])
		$TextureRect / All / VBoxContainer.add_child(instance)
	
	while $TextureRect / All / VBoxContainer.get_child_count() <= 5:
		var ins = M.MiscritEmpty.instance()
		$TextureRect / All / VBoxContainer.add_child(ins)
	
	var evo_more = $TextureRect / All / OtherMore
	evo_more.disabled = stroke == 0
	evo_more.modulate = Color(0.741176, 0.741176, 0.741176, 0.877843) if evo_more.disabled else Color(1, 1, 1, 1)
func _on_Close_pressed():
	visible = false
	pass

func presset_evo():
	var letter = M.get_evolution(M.UR_MISCRITS[CurrentID])
	$StatsPopup / Panel / Back / TeamContainer / Sprite.texture = load("res://Assets/Miscrits/Miscrits/" + M.UR_MISCRITS[CurrentID]["Id"] + letter + ".png")
	
	
	$StatsPopup / Panel / Back / TeamContainer / AnimationPlayer.play("Breath")
var Need_abillity_Scene = false
var old_stats = {}
func _on_Train_pressed():
	$StatsPopup / Panel / Notice.text = M.UR_MISCRITS[CurrentID]["Name"] + " is now level " + str(M.UR_MISCRITS[CurrentID]["Level"] + 1) + "!"
	$StatsPopup / Panel / Back.texture = load("res://Assets/Ui/TrainBackground/" + str(M.Miscrits_Data[M.UR_MISCRITS[CurrentID]["Id"]]["Element"]) + ".png")
	$StatsPopup / Panel / evol1 / Icon.get_node("LevelBg").visible = false
	$StatsPopup / Panel / evol2 / Icon.get_node("LevelBg").visible = false
	var evolit_level = M.UR_MISCRITS[CurrentID]["Level"]
	
	if evolit_level >= 20:
		evolit_level -= 20
	elif evolit_level >= 10:
		evolit_level -= 10
	print(evolit_level)
	for child in $StatsPopup / Panel / LevelBox.get_children():
		var level = child.get_index() + 1
		if evolit_level >= level:
			child.modulate = Color(0, 1, 0, 1)
			child.self_modulate = Color(1, 1, 1, 1)
		elif level == evolit_level + 1:
			child.modulate = Color(1, 0.890196, 0)
			child.self_modulate = Color(1, 1, 1, 1)
		else :
			child.self_modulate = Color(1, 1, 1, 0)
	break_anim = false
	playing = true
	Need_abillity_Scene = false
	for visibledis in $StatsPopup / Panel / Stats / GridContainer.get_children():
		visibledis.get_node("HBoxContainer/Buff").visible = false
	presset_evo()
	if M.UR_MISCRITS[CurrentID]["CXP"] >= M.EXP_NEED_TO_LEVEL_UP[M.UR_MISCRITS[CurrentID]["Level"] + 1] or M.Free_Train:
		if M.UR_MISCRITS[CurrentID]["Level"] <= 29:
			var letter = M.get_evolution(M.UR_MISCRITS[CurrentID])
			$StatsPopup / Panel / evol1 / Icon.texture = load("res://Assets/Miscrits/Icons/" + M.UR_MISCRITS[CurrentID]["Id"] + letter + ".png")
			if letter == "a":
				$StatsPopup / Panel / evol2 / Icon.texture = load("res://Assets/Miscrits/Icons/" + M.UR_MISCRITS[CurrentID]["Id"] + "b.png")
			elif letter == "b":
				$StatsPopup / Panel / evol2 / Icon.texture = load("res://Assets/Miscrits/Icons/" + M.UR_MISCRITS[CurrentID]["Id"] + "c.png")
			elif letter == "c":
				$StatsPopup / Panel / evol2 / Icon.texture = load("res://Assets/Miscrits/Icons/" + M.UR_MISCRITS[CurrentID]["Id"] + "d.png")
			elif letter == "d":
				$StatsPopup / Panel / evol2 / Icon.texture = load("res://Assets/Ui/170_MiscritUnknown.png")
			get_tree().get_root().set_disable_input(true)
			$StatsPopup / Panel / Stats / AnimationPlayer.play("Spawn")
			yield ($StatsPopup / Panel / Stats / AnimationPlayer, "animation_finished")
			get_tree().get_root().set_disable_input(false)
			for stat in M.Stat_names:
				var stata_value = M.get_stat(stat, M.UR_MISCRITS[CurrentID])
				old_stats[stat] = stata_value
				$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Value").text = str(stata_value)
			M.UR_MISCRITS[CurrentID]["Level"] += 1
			if M.Miscrits_Data[M.UR_MISCRITS[CurrentID]["Id"]]["Abilities"].has(M.UR_MISCRITS[CurrentID]["Level"]):
				Need_abillity_Scene = true
			for stat in ["hp", "spd", "ea", "pa", "ed", "pd"]:
				var stata_value = M.get_stat(stat, M.UR_MISCRITS[CurrentID])
				var value = stata_value - old_stats[stat]
				
				for n in 10:
					if break_anim:
						break
						
					var rand_val = value
					while value == rand_val:
						rand_val = value + M.rng.randi_range( - 2, 3)
					$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Buff").text = "+" + str(clamp(rand_val, 0, 100))
					$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Buff").visible = true
					
					yield (get_tree().create_timer(0.07), "timeout")
				
				$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Buff").text = "+" + str(value)
			playing = false
			
			M.UR_MISCRITS[CurrentID]["CHP"] = 600
			M.UR_MISCRITS[CurrentID]["CXP"] = 0
			M.MainUiTeamContainer.Update_Team()
			Update_Abillities(M.UR_MISCRITS[CurrentID], 0)
			Update_Miscrits_Unique(CurrentID)
			
	pass
var break_anim = false
var playing = true
func break_anim(old_stata):
	for stat in ["hp", "spd", "ea", "pa", "ed", "pd"]:
		var stata_value = M.get_stat(stat, M.UR_MISCRITS[CurrentID])
		$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Buff").text = "+" + str(stata_value - old_stata[stat])
		$StatsPopup / Panel / Stats / GridContainer.get_node(stat).get_node("HBoxContainer/Buff").visible = true
func _on_Stats_Exit_pressed():
	if not playing:
		$StatsPopup / Panel / Stats / AnimationPlayer.play("Exit")
		get_tree().get_root().set_disable_input(true)
		if Need_abillity_Scene:
			$AbillityPopup / AnimationPlayer.play("Spawn")
			$AbillityPopup / Abi / Background / GridContainer / Ability.Setup(M.Miscrits_Data[M.UR_MISCRITS[CurrentID]["Id"]]["Abilities"][M.UR_MISCRITS[CurrentID]["Level"]])
			
			$AbillityPopup / Abi / Notice.text = M.UR_MISCRITS[CurrentID]["Name"] + " learned a new Abillity!!"
		else :
			Update_Stats()
		get_tree().get_root().set_disable_input(false)
	else :
		playing = false
		break_anim = true
		break_anim(old_stats)
	pass


func _on_Abillity_Exit_pressed():
	$AbillityPopup / AnimationPlayer.play("Exit")
	Update_Stats()
	pass


func _on_AbillitiesMore_pressed():
	Update_Abillities(M.UR_MISCRITS[CurrentID], Ability_Stroke - 1)
	pass


func _on_AbillitiesLess_pressed():
	Update_Abillities(M.UR_MISCRITS[CurrentID], Ability_Stroke + 1)
	pass


func _on_OtherMore_pressed():
	stroke -= 1
	update_other()
	pass


func _on_OtherLess_pressed():
	stroke += 1
	update_other()
	pass


func _on_SettingButton_pressed():
	if $TextureRect / Background / SettingButton / Setting.visible:
		$TextureRect / Background / SettingButton / AnimationPlayer.play_backwards("spawn")
		yield ($TextureRect / Background / SettingButton / AnimationPlayer, "animation_finished")
		$TextureRect / Background / SettingButton / Setting.visible = false
	else :
		$TextureRect / Background / SettingButton / Setting.visible = true
		$TextureRect / Background / SettingButton / AnimationPlayer.play("spawn")
	pass


func _on_Rename_Exit_pressed():
	$RenamePopup.visible = false
	pass


func _on_SaveName_pressed():
	if $RenamePopup / TextureRect / NameLine.text != "":
		M.UR_MISCRITS[CurrentID]["Name"] = $RenamePopup / TextureRect / NameLine.text
		Update_Miscrits_Unique(CurrentID)
	_on_Rename_Exit_pressed()
	pass


func _on_Rename_pressed():
	$RenamePopup / TextureRect / NameLine.text = ""
	$RenamePopup.visible = true
	pass


func _on_Release_pressed():
	if not CurrentID in M.UR_TEAM:
		if M.UR_MISCRITS.has(CurrentID):
			M.UR_MISCRITS.erase(CurrentID)
			Update(M.UR_TEAM[0], true)
	pass
